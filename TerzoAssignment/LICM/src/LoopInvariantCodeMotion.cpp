#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"

#include "llvm/Analysis/LoopInfo.h"

#include <vector>
#include <unordered_set>

using namespace llvm;

namespace {

// New PM implementation
// Invocare il passo nella cartella /test nel seguente modo: 
// opt -S -load-pass-plugin ../build/libLoopInvariantCodeMotion.so -p loop-invariant-code-motion Test.m2r.ll -o Test.optimized.ll
// Pass per identificare istruzioni loop-invariant (senza code motion)
struct LoopInvariantCodeMotion: PassInfoMixin<LoopInvariantCodeMotion>{

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    // Otteniamo l'analisi dei loop per la funzione
        LoopInfo &LI = AM.getResult<LoopAnalysis>(F);

        // Iteriamo su tutti i loop top-level
        for (Loop *L : LI) {
            processLoop(L);
        }


    return PreservedAnalyses::all();
  }

  private:

    // Analizza un loop e identifica le istruzioni invariant
    void processLoop(Loop *L) {

        // Vettore delle istruzioni invariant trovate
        std::vector<Instruction*> InvariantInsts;

        // Set per lookup veloce (serve per iterazione a punto fisso)
        std::unordered_set<Instruction*> InvariantSet;

        // Iteriamo fino a stabilizzazione (fixed point)
        bool changed = true;

        while (changed) {
            changed = false;

            // Scorriamo tutti i basic block del loop
            for (BasicBlock *BB : L->blocks()) {

                // Scorriamo tutte le istruzioni del blocco
                for (Instruction &I : *BB) {

                    // Se già marcata invariant, salta
                    if (InvariantSet.count(&I))
                        continue;

                    // Controlla se è loop invariant
                    if (isLoopInvariant(I, L, InvariantSet)) {

                        // Aggiungiamo al vettore
                        InvariantInsts.push_back(&I);

                        // Segniamo nel set
                        InvariantSet.insert(&I);

                        // Serve un'altra iterazione
                        changed = true;
                    }
                }
            }
        }

        // DEBUG: stampa le istruzioni trovate
        for (Instruction *I : InvariantInsts) {
            errs() << "Loop Invariant: ";
            I->print(errs());
            errs() << "\n";
        }

        // Ricorsione sui sotto-loop 
        for (Loop *SubLoop : L->getSubLoops()) {
            processLoop(SubLoop);
        }
    }

    // Funzione che verifica se una istruzione è loop-invariant
    bool isLoopInvariant(Instruction &I,
                         Loop *L,
                         std::unordered_set<Instruction*> &InvariantSet) {

        // Escludiamo istruzioni con effetti collaterali
        if (I.mayHaveSideEffects())
            return false;

        // Escludiamo terminatori (branch, return, ecc.)
        if (I.isTerminator())
            return false;
        
        // Se l'istruzione non è binaria, allora non la analizziamo
        if(!I.isBinaryOp())
            return false;
        
        // Analizziamo tutti gli operandi dell'istruzione
        // prendiamo gli usi (operands)
        for (Value *Op : I.operands()) {

            // Caso 1: costante → sempre invariant
            if (isa<Constant>(Op))
                continue;

            // Caso 2: parametro della funzione → invariant
            //if (isa<Argument>(Op))
            //    continue;

            // Caso 3: valore definito da un'altra istruzione
            // risaliamo alla definizione
            if (Instruction *OpInst = dyn_cast<Instruction>(Op)) {

                // Se definito FUORI dal loop → ok
                if (!L->contains(OpInst))
                    continue;

                // Se definito nel loop ma già invariant → ok
                if (InvariantSet.count(OpInst))
                    continue;

                // Altrimenti NON invariant
                return false;
            }

            // Qualsiasi altro caso → conservativo → non invariant
            return false;
        }

        // Tutti gli operandi soddisfano le condizioni → invariant
        return true;
    }


    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getLoopInvariantCodeMotionPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "LoopInvariantCodeMotion", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "loop-invariant-code-motion") {
                    FPM.addPass(LoopInvariantCodeMotion());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize LoopInvariantCodeMotion when added to the pass pipeline on the
// command line, i.e. via '-passes=loop-invariant-code-motion'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getLoopInvariantCodeMotionPluginInfo();
}