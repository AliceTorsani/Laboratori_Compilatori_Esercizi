#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"

using namespace llvm;

namespace {

// New PM implementation
//Invocare il passo nella cartella /test nel seguente modo:
//opt -S -load-pass-plugin ../build/libAlgId.so -p algebraic-identity Foo.ll -o Foo.optimized.ll
struct AlgId: PassInfoMixin<AlgId> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    outs()<<"Eseguito Passo di Algebraic Identity"<<"\n";

    //Passo di algebraic identity
    std::vector<Instruction*> toRemove;

    for (auto BBIter = F.begin(); BBIter != F.end(); ++BBIter) {
        BasicBlock &B = *BBIter;

        for (auto InstIter = B.begin(); InstIter != B.end(); ++InstIter) {
            Instruction &I = *InstIter;

            auto *binOp = dyn_cast<BinaryOperator>(&I);
            if (!binOp) continue;

            Value *op1 = binOp->getOperand(0);
            Value *op2 = binOp->getOperand(1);

            // ADD
            if (binOp->getOpcode() == Instruction::Add) {

                if (auto *C = dyn_cast<ConstantInt>(op1)) {
                    if (C->isZero()) {
                        I.replaceAllUsesWith(op2);
                        toRemove.push_back(&I);
                    }
                } 
                else if (auto *C = dyn_cast<ConstantInt>(op2)) {
                    if (C->isZero()) {
                        I.replaceAllUsesWith(op1);
                        toRemove.push_back(&I);
                    }
                }
            }

            // MUL
            if (binOp->getOpcode() == Instruction::Mul) {

                if (auto *C = dyn_cast<ConstantInt>(op1)) {
                    if (C->isOne()) {
                        I.replaceAllUsesWith(op2);
                        toRemove.push_back(&I);
                    }
                } 
                else if (auto *C = dyn_cast<ConstantInt>(op2)) {
                    if (C->isOne()) {
                        I.replaceAllUsesWith(op1);
                        toRemove.push_back(&I);
                    }
                }
            }
        }
    }

    // Eliminazione istruzioni
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
llvm::PassPluginLibraryInfo getAlgIdPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "AlgId", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "algebraic-identity") {
                    FPM.addPass(AlgId());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize AlgId when added to the pass pipeline on the
// command line, i.e. via '-passes=algebraic-identity'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getAlgIdPluginInfo();
}
