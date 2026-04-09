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

// Definizione del pass come Function Pass
struct AlgId: PassInfoMixin<AlgId> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    outs()<<"Eseguito Passo di Algebraic Identity"<<"\n";

    //Passo di algebraic identity

    // Vettore per salvare le istruzioni da eliminare
    // (non le eliminiamo subito per evitare problemi con gli iteratori)
    std::vector<Instruction*> toRemove;

    // Iterazione su tutti i Basic Block della funzione
    for (auto BBIter = F.begin(); BBIter != F.end(); ++BBIter) {
        BasicBlock &B = *BBIter;

        // Iterazione su tutte le istruzioni del Basic Block
        for (auto InstIter = B.begin(); InstIter != B.end(); ++InstIter) {
            Instruction &I = *InstIter;

            // Controlliamo se l'istruzione è un'operazione binaria (add, mul, ecc.)
            auto *binOp = dyn_cast<BinaryOperator>(&I);
            if (!binOp) continue;

            // Recuperiamo i due operandi
            Value *op1 = binOp->getOperand(0);
            Value *op2 = binOp->getOperand(1);

            // CASO ADD (x + 0 oppure 0 + x)
            if (binOp->getOpcode() == Instruction::Add) {

                // Caso: 0 + x
                if (auto *C = dyn_cast<ConstantInt>(op1)) {
                    if (C->isZero()) {
                        // Sostituisce tutti gli usi dell'istruzione con op2 (cioè x)
                        I.replaceAllUsesWith(op2);
                        // Segna l'istruzione per la rimozione
                        toRemove.push_back(&I);
                    }
                } 
                // Caso: x + 0
                else if (auto *C = dyn_cast<ConstantInt>(op2)) {
                    if (C->isZero()) {
                        I.replaceAllUsesWith(op1);
                        toRemove.push_back(&I);
                    }
                }
            }

            // CASO MUL (x * 1 oppure 1 * x)
            if (binOp->getOpcode() == Instruction::Mul) {

                // Caso: 1 * x
                if (auto *C = dyn_cast<ConstantInt>(op1)) {
                    if (C->isOne()) {
                        I.replaceAllUsesWith(op2);
                        toRemove.push_back(&I);
                    }
                } 
                // Caso: x * 1
                else if (auto *C = dyn_cast<ConstantInt>(op2)) {
                    if (C->isOne()) {
                        I.replaceAllUsesWith(op1);
                        toRemove.push_back(&I);
                    }
                }
            }
        }
    }

    // RIMOZIONE DELLE ISTRUZIONI
    // Ora possiamo eliminare le istruzioni segnate
    // (in sicurezza, fuori dal ciclo principale)
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
