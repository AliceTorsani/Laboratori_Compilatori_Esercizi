#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/ADT/DepthFirstIterator.h"

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Dominators.h"

#include <vector>
#include <algorithm>

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

    // Otteniamo il Dominator Tree
        DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);

        // Iteriamo su tutti i loop top-level
        for (Loop *L : LI) {
            outs() << "\n\n--------inizio loop--------\n\n";
            processLoop(L, DT, LI);
        }


    return PreservedAnalyses::all();
  }

  private:

    // Analizza un loop: identifica le istruzioni invariant, poi quelle candidate alla code motion,
    //infine muove le istruzioni nel preheader
    void processLoop(Loop *L, 
                     DominatorTree &DT,
                     LoopInfo &LI) {

        // PREHEADER

        // LICM richiede un preheader.
        // Se non esiste, lo creiamo.

        BasicBlock *Preheader = L->getLoopPreheader();

        if (!Preheader) {

            errs() << "Creating preheader for loop\n";

            // Funzione utility di LLVM
            // che crea automaticamente il preheader.

            Preheader = InsertPreheaderForLoop(L, &DT, &LI, nullptr, false);

            // Se fallisce → abbandona
            if (!Preheader)
                return;
        }
        
        // Vettore delle istruzioni invariant trovate
        std::vector<Instruction*> InvariantInsts;

        // FASE 1
        // Identificazione istruzioni loop invariant

            // Scorriamo tutti i basic block del loop
            for (BasicBlock *BB : L->blocks()) {
                
                outs() << "\nblocco del loop: ";
                BB->printAsOperand(outs(), false);
                outs() << "\nil quale domina: ";
                
                SmallVector<BasicBlock*> discendenti;
                DT.getDescendants(BB, discendenti);

                for(auto c : discendenti) {
                    outs() << "\n\t ⊢";
                    c->printAsOperand(outs(), false);
                }
            

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
            outs() << "\n\n--------fine loop--------\n\n";
        

        // DEBUG: stampa le istruzioni trovate
        for (Instruction *I : InvariantInsts) {
            errs() << "Loop Invariant: ";
            I->print(errs());
            errs() << "\n";
        }

        // FASE 2
        // Ricerca candidate alla code motion

        // Otteniamo i blocchi di uscita del loop
        SmallVector<BasicBlock*, 8> ExitBlocks;
        L->getExitBlocks(ExitBlocks);

        // Candidate da spostare
        std::vector<Instruction*> HoistCandidates;
        //    1. vado a prendere ogni exit block del loop
        SmallVector<BasicBlock*> exitBlocks;
        L->getExitBlocks(exitBlocks);

        // Analizziamo tutte le invariant
        for (Instruction *I : InvariantInsts) {

            //----------------------------------------------------
            // CONDIZIONE 1
            // Dominanza su tutte le uscite
            //----------------------------------------------------

            
            
            //riempio il vettore con tutti i blocchi dominati dal BB al quale appartiene l'istruzione corrente
            SmallVector<BasicBlock*> discendenti;
            DT.getDescendants(I->getParent(), discendenti);
            
            //controllo se ogni exitBlock è tra i discendenti del nodo
            bool dominatesExits = true;
            //if (!DT.dominates(I->getParent(), ExitBB))
            for(auto eB : exitBlocks) {
                outs() << "exit block esaminato: ";
                eB->printAsOperand(errs(), false);
                
                bool isEbInChild = false;
                
                //controllo se tra i discendenti del nodo corrente c'è l'exitBlock
                for(auto dB : discendenti) {
                    outs() << " con basic block: ";
                    dB->printAsOperand(errs(), false);
                    outs() << "\n\t\t\t ";


                    if(dB == eB) { isEbInChild=true; break;}
                }
                if(!isEbInChild) { dominatesExits = false; } //TODO: break?
            }

            if(!dominatesExits) {
                
                outs() << "\nIstruzione il cui blocco NON domina tutte le uscite: ";
                I->print(errs());
                outs() << "\n";
                
            } else {
                outs() << "\nIstruzione il cui blocco DOMINA tutte le uscite: ";
                I->print(errs());
                outs() << "\n";
            }

            //----------------------------------------------------
            // CONDIZIONE 2
            // Variabile dead fuori dal loop
            //----------------------------------------------------

            bool deadOutside = isDeadOutsideLoop(*I, L);

            //----------------------------------------------------
            // CONDIZIONE 3
            // Dominanza su tutti gli usi nel loop
            //----------------------------------------------------

            bool dominatesUses = true;

            for (User *U : I->users()) {

                // user() implementa la catena DEF-USE
                // (dalla definizione agli usi)

                if (Instruction *UseInst = dyn_cast<Instruction>(U)) {

                    // Consideriamo solo usi interni al loop
                    if (L->contains(UseInst)) {

                        // I deve dominare il suo uso
                        if (!DT.dominates(I, UseInst)) {
                            dominatesUses = false;
                            break;
                        }
                    }
                }
            }

            //----------------------------------------------------
            // Se soddisfa le condizioni → candidata
            //----------------------------------------------------

            if ((dominatesExits || deadOutside) &&
                dominatesUses) {

                errs() << "Candidate for hoisting: ";
                I->print(errs());
                errs() << "\n";

                HoistCandidates.push_back(I);
            }
        }

        //--------------------------------------------------------
        // FASE 3
        // CODE MOTION
        //--------------------------------------------------------

        // Vettore temporaneo che conterrà
        // le istruzioni nell'ordine DFS corretto

        std::vector<Instruction*> OrderedHoist;

        // DFS del CFG del loop
        // Utile per rispettare dipendenze tra invariant

        for (BasicBlock *BB : depth_first(L->getHeader())) {

            // Consideriamo solo blocchi del loop
            if (!L->contains(BB))
                continue;

            // Scorriamo le istruzioni del blocco
            for (Instruction &I : *BB) {

                // Verifica se è candidata all'hoisting
                if (std::find(HoistCandidates.begin(),
                              HoistCandidates.end(),
                              &I) != HoistCandidates.end()) {
                    
                    // Si verifica che tutte le istruzioni invarianti da cui l'istruzione I dipende
                    // sono state spostate (salvate in OrderedHoist)
                    bool allGood = true;

                    // Prende gli operandi dell'istruzione
                    for(Value *Op : I.operands()) {
                        
                        // Se il valore dell'operando è definito da un'altra istruzione
                        // risaliamo alla definizione di essa
                        if (Instruction *OpInst = dyn_cast<Instruction>(Op)) {
                            
                            // Verifica se è già stata inserita tra le istruzioni da spostare
                            // Se non si trova l'istruzione allora non è da inserire in OrderdHoist
                            if (std::find(OrderedHoist.begin(), OrderedHoist.end(), OpInst) == OrderedHoist.end()) {
                                outs() << "istruzione rimossa in fase finale: ";
                                I.printAsOperand(outs());
                                outs() << "\n-------\n";
                                allGood = false;
                            }
                        }
                    }
                    
                    // Se  tutte le istruzioni invarianti da cui l'istruzione I dipende
                    // sono state spostate si sposta anch'essa
                    if(allGood) {
                        // Salva nel vettore temporaneo le istruzioni da spostare
                        OrderedHoist.push_back(&I);
                    }
                }
            }
        }

        //--------------------------------------------------------
        // CODE MOTION
        //--------------------------------------------------------

        for (Instruction *I : OrderedHoist) {

            errs() << "Hoisting instruction: ";
            I->print(errs());
            errs() << "\n";

            // Sposta l'istruzione nel preheader
            // prima del terminatore.
            I->moveBefore(Preheader->getTerminator());
        }


        // Ricorsione sui sotto-loop (analizza eventuali sotto-loop)
        for (Loop *SubLoop : L->getSubLoops()) {
            processLoop(SubLoop, DT, LI);
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

        if (!(isa<BinaryOperator>(&I) || isa<UnaryInstruction>(&I) || I.isCast()))
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

    // Verifica se il valore definito è dead fuori dal loop
    bool isDeadOutsideLoop(Instruction &I, Loop *L) {

        // Scorriamo tutti gli usi del valore definito da I
        for (User *U : I.users()) {

            if (Instruction *UseInst = dyn_cast<Instruction>(U)) {

                // Se troviamo un uso fuori dal loop
                // allora NON è dead.

                if (!L->contains(UseInst))
                    return false;
            }
        }

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