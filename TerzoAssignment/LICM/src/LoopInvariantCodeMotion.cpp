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

            // Scorriamo tutti i basic block del loop
            for (BasicBlock *BB : L->blocks()) {

                // Scorriamo tutte le istruzioni del blocco
                for (Instruction &I : *BB) {

                    // Controlla se è loop invariant
                    if (isLoopInvariant(I, L, InvariantInsts)) {

                        // Se il vettore non contiene già l'istruzione, allora la inseriamo
                        // (evito di inserire duplicati)
                        if (std::find(InvariantInsts.begin(),
                                        InvariantInsts.end(),
                                        &I) == InvariantInsts.end())
                        {
                            // Aggiungiamo al vettore
                            InvariantInsts.push_back(&I);
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
                         Loop *L, std::vector<Instruction*> &InvariantInsts) {
        
        // Escludiamo istruzioni con effetti collaterali (store, chiamate a funzione, ecc.)
        if (I.mayHaveSideEffects())
            return false;

        // Escludiamo terminatori (branch, return, ecc.)
        if (I.isTerminator())
            return false;

        // Escludiamo istruzioni PHI
        if (isa<PHINode>(&I))
            return false;
        
        // Escludiamo le load
        if (isa<LoadInst>(&I))
            return false;

        // Controlla che le istruzioni del tipo a=5 vengano analizzate
        // Se l'istruzione non è binaria, allora non la analizziamo
        // e se non è un'istruzione del tipo a=5 allora non la analizziamo
        // Considera SOLO:
        // - binary operations
        // - unary instructions

        if (!(isa<BinaryOperator>(&I) || isa<UnaryInstruction>(&I)))
            return false;
        
        // Analizziamo tutti gli operandi dell'istruzione
        // prendiamo gli usi (operands)
        for (Value *Op : I.operands()) {

            // Caso 1: costante → sempre invariant
            if (isa<Constant>(Op))
                continue;

            // Caso 2: valore definito da un'altra istruzione
            // risaliamo alla definizione
            if (Instruction *OpInst = dyn_cast<Instruction>(Op)) {

                // Se definito FUORI dal loop → ok
                if (!L->contains(OpInst))
                    continue;

                // Se definito nel loop ma già invariant → ok
                // (Cioè se il vettore contiene già l'istruzione -> ok)
                if (std::find(InvariantInsts.begin(),
                                InvariantInsts.end(),
                                OpInst) != InvariantInsts.end())
                {
                    continue;
                }

                // Se definita nel loop:
                // verifico ricorsivamente
                // controllo ricorsivo per controllare
                // se l'istruzione che definsce l'operando è anch'essa loop invariant
                if (isLoopInvariant(*OpInst, L, InvariantInsts))
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