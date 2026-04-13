#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

// New PM implementation
// Invocare il passo nella cartella /test nel seguente modo:
// opt -S -load-pass-plugin ../build/libMultiOpt.so -p multi-instruction-optimization Foo.ll -o Foo.optimized.ll
// Pass per ottimizzazioni su più istruzioni 
struct MultiOpt: PassInfoMixin<MultiOpt> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    outs()<<"eseguito passo di multi-instruction optimization"<<"\n";

      // Vettore per salvare le istruzioni da eliminare dopo
        std::vector<Instruction*> toRemove;

        // =========================
        // Iterazione su tutti i Basic Block della funzione
        // =========================
        for (auto BBIter = F.begin(); BBIter != F.end(); ++BBIter) {
            BasicBlock &B = *BBIter;

            // Iterazione su tutte le istruzioni del Basic Block
            for (auto InstIter = B.begin(); InstIter != B.end(); ++InstIter) {
                Instruction &I = *InstIter;

                // Consideriamo solo operazioni binarie (add, sub, ...)
                auto *binOp = dyn_cast<BinaryOperator>(&I);
                if (!binOp) continue;

                // =====================================================
                // CASO 1: (b + k) - k → b
                // =====================================================
                if (binOp->getOpcode() == Instruction::Sub) {

                    // I è una sottrazione: c = X - k
                    Value *X = binOp->getOperand(0); // candidato: (b + k)
                    Value *k2 = binOp->getOperand(1); // costante k

                    // Verifica che k sia una costante
                    auto *C2 = dyn_cast<ConstantInt>(k2);
                    if (!C2) continue;

                    // Controlla se X è un'istruzione (add)
                    auto *addInst = dyn_cast<BinaryOperator>(X);
                    if (!addInst || addInst->getOpcode() != Instruction::Add)
                        continue;

                    // Operandi dell'add: (b + k) oppure (k + b)
                    Value *addOp1 = addInst->getOperand(0);
                    Value *addOp2 = addInst->getOperand(1);

                    ConstantInt *Cadd = nullptr;
                    Value *b = nullptr;

                    // Caso: b + k
                    if ((Cadd = dyn_cast<ConstantInt>(addOp2))) {
                        // Controlla che k sia lo stesso della sub
                        if (Cadd->equalsInt(C2->getZExtValue())) {
                            b = addOp1;
                        }
                    }
                    // Caso: k + b
                    else if ((Cadd = dyn_cast<ConstantInt>(addOp1))) {
                        if (Cadd->equalsInt(C2->getZExtValue())) {
                            b = addOp2;
                        }
                    }

                    // Se non troviamo il pattern corretto → salta
                    if (!b) continue;

                    // =========================
                    // OTTIMIZZAZIONE
                    // =========================

                    // Sostituisce tutti gli usi di (b + k) - k con b
                    I.replaceAllUsesWith(b);

                    // Segna la sub per la rimozione
                    toRemove.push_back(&I);

                    // Se l'add non è più usata → rimuoverla
                    //if (addInst->use_empty())
                        //toRemove.push_back(addInst);
                }

                // =====================================================
                // CASO 2: (b - k) + k → b
                // =====================================================
                if (binOp->getOpcode() == Instruction::Add) {

                    // I è una somma: c = X + k
                    Value *X = binOp->getOperand(0); // candidato: (b - k)
                    Value *k2 = binOp->getOperand(1); // costante k

                    // Verifica che k sia una costante
                    auto *C2 = dyn_cast<ConstantInt>(k2);
                    if (!C2) continue;

                    // Controlla se X è una sottrazione
                    auto *subInst = dyn_cast<BinaryOperator>(X);
                    if (!subInst || subInst->getOpcode() != Instruction::Sub)
                        continue;

                    // Operandi della sottrazione: b - k
                    Value *b = subInst->getOperand(0);
                    Value *k1 = subInst->getOperand(1);

                    // Verifica che k1 sia costante
                    auto *C1 = dyn_cast<ConstantInt>(k1);
                    if (!C1) continue;

                    // Controlla che k1 == k2 (stessa costante)
                    if (!C1->equalsInt(C2->getZExtValue()))
                        continue;

                    // =========================
                    // OTTIMIZZAZIONE
                    // =========================

                    // Sostituisce (b - k) + k con b
                    I.replaceAllUsesWith(b);

                    // Segna la add per la rimozione
                    toRemove.push_back(&I);

                    // Se la sub non è più usata → rimuoverla
                    //if (subInst->use_empty())
                        //toRemove.push_back(subInst);
                }
            }
        }

        // =========================
        // RIMOZIONE ISTRUZIONI
        // =========================

        // Rimuove tutte le istruzioni segnate
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
llvm::PassPluginLibraryInfo getMultiOptPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "MultiOpt", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "multi-instruction-optimization") {
                    FPM.addPass(MultiOpt());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize MultiOpt when added to the pass pipeline on the
// command line, i.e. via '-passes=multi-instruction-optimization'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getMultiOptPluginInfo();
}