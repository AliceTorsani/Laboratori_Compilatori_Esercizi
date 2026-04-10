#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

// New PM implementation
//Invocare il passo nella cartella /test nel seguente modo:
//opt -S -load-pass-plugin ../build/libStrRed.so -p strength-reduction Foo.ll -o Foo.optimized.ll
// Pass di Strength Reduction
struct StrRed: PassInfoMixin<StrRed> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    outs()<<"eseguito passo di strength reduction"<<"\n";

    std::vector<Instruction*> toRemove;

      // Iterazione sui Basic Block
      for (auto BBIter = F.begin(); BBIter != F.end(); ++BBIter) {
          BasicBlock &B = *BBIter;

          // Iterazione sulle istruzioni
          for (auto InstIter = B.begin(); InstIter != B.end(); ++InstIter) {
              Instruction &I = *InstIter;

              // Consideriamo solo operazioni binarie
              auto *binOp = dyn_cast<BinaryOperator>(&I);
              if (!binOp) continue;

              IRBuilder<> builder(&I);

              Value *op1 = binOp->getOperand(0);
              Value *op2 = binOp->getOperand(1);

              // =====================================================
              // MOLTIPLICAZIONE
              // =====================================================
              if (binOp->getOpcode() == Instruction::Mul) {

                  ConstantInt *C = dyn_cast<ConstantInt>(op2);
                  Value *X = op1;

                  // Se la costante è a sinistra, scambiamo
                  if (!C) {
                      C = dyn_cast<ConstantInt>(op1);
                      X = op2;
                  }

                  if (!C) continue;

                  APInt val = C->getValue();

                  // -------------------------
                  // x * 2^n → x << n
                  // -------------------------
                  if (val.isPowerOf2()) {
                      unsigned shift = val.logBase2();

                      Value *newInst = builder.CreateShl(X, shift);

                      I.replaceAllUsesWith(newInst);
                      toRemove.push_back(&I);
                  }

                  // -------------------------
                  // x * (2^n - 1)
                  // es: x * 15 → (x << 4) - x
                  // -------------------------
                  else if ((val + 1).isPowerOf2()) {
                      APInt tmp = val + 1;
                      unsigned shift = tmp.logBase2();

                      Value *sh = builder.CreateShl(X, shift);
                      Value *sub = builder.CreateSub(sh, X);

                      I.replaceAllUsesWith(sub);
                      toRemove.push_back(&I);
                  }

                  // -------------------------
                  // x * (2^n + 1)
                  // es: x * 9 → (x << 3) + x
                  // -------------------------
                  else if ((val - 1).isPowerOf2()) {
                      APInt tmp = val - 1;
                      unsigned shift = tmp.logBase2();

                      Value *sh = builder.CreateShl(X, shift);
                      Value *add = builder.CreateAdd(sh, X);

                      I.replaceAllUsesWith(add);
                      toRemove.push_back(&I);
                  }
              }

              // =====================================================
              // DIVISIONE
              // =====================================================
              if (binOp->getOpcode() == Instruction::UDiv ||
                  binOp->getOpcode() == Instruction::SDiv) {

                  auto *C = dyn_cast<ConstantInt>(op2);
                  if (!C) continue;

                  APInt val = C->getValue();
                  bool isSigned = (binOp->getOpcode() == Instruction::SDiv);

                  // -------------------------
                  // x / 2^n → shift
                  // -------------------------
                  if (val.isPowerOf2()) {
                      unsigned shift = val.logBase2();

                      Value *newInst = isSigned ?
                          builder.CreateAShr(op1, shift) :
                          builder.CreateLShr(op1, shift);

                      I.replaceAllUsesWith(newInst);
                      toRemove.push_back(&I);
                  }

                  // -------------------------
                  // x / (2^n - 1)  (APPROSSIMATO)
                  // es: x / 15 ≈ (x >> 4) + (x >> 4)
                  // -------------------------
                  else if ((val + 1).isPowerOf2()) {
                      APInt tmp = val + 1;
                      unsigned shift = tmp.logBase2();

                      Value *sh1 = isSigned ?
                          builder.CreateAShr(op1, shift) :
                          builder.CreateLShr(op1, shift);

                      Value *sh2 = isSigned ?
                          builder.CreateAShr(op1, shift) :
                          builder.CreateLShr(op1, shift);

                      Value *add = builder.CreateAdd(sh1, sh2);

                      I.replaceAllUsesWith(add);
                      toRemove.push_back(&I);
                  }

                  // -------------------------
                  // x / (2^n + 1)  (APPROSSIMATO)
                  // es: x / 9 ≈ (x >> 3) - (x >> 4)
                  // -------------------------
                  else if ((val - 1).isPowerOf2()) {
                      APInt tmp = val - 1;
                      unsigned shift = tmp.logBase2();

                      Value *sh1 = isSigned ?
                          builder.CreateAShr(op1, shift) :
                          builder.CreateLShr(op1, shift);

                      Value *sh2 = isSigned ?
                          builder.CreateAShr(op1, shift + 1) :
                          builder.CreateLShr(op1, shift + 1);

                      Value *sub = builder.CreateSub(sh1, sh2);

                      I.replaceAllUsesWith(sub);
                      toRemove.push_back(&I);
                  }
              }
          }
      }

      // =====================================================
      // RIMOZIONE ISTRUZIONI
      // =====================================================
      for (auto I = toRemove.begin(); I != toRemove.end(); ++I) {
          (*I)->eraseFromParent();
      }


      return PreservedAnalyses::all();
  }
    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getStrRedPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "StrRed", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "strength-reduction") {
                    FPM.addPass(StrRed());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize StrRed when added to the pass pipeline on the
// command line, i.e. via '-passes=strength-reduction'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getStrRedPluginInfo();
}