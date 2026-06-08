#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Analysis/ScalarEvolution.h"

#include "llvm/IR/Dominators.h"
#include "llvm/Analysis/PostDominators.h"

#include "llvm/Transforms/Utils/LoopSimplify.h"

#include <algorithm>


using namespace llvm;

//TODO controllare che ci sia un solo exit block -> fatto
//TODO controllare quando viene controllato il preheader

namespace {

// New PM implementation
// Prima di eseguite il passo, eseguire nella cartella /test:
// opt -passes="loop-simplify,loop-rotate" Test.m2r.ll -S -o Test.simplified.ll
// Dopodichè eseguire il passo 
// Invocare il passo nella cartella /test nel seguente modo:
// opt -S -load-pass-plugin ../build/libLoopFusion.so -p my-loop-fusion Test.simplified.ll -o Test.optimized.ll 
//
// IMPORTANTE: NON USARE LOOP-ROTATE
//
// Invocare il passo nella cartella /test nel seguente modo:
// opt -S -load-pass-plugin ../build/libLoopFusion.so -p my-loop-fusion Test.m2r.ll -o Test.optimized.ll 
struct LoopFusion: PassInfoMixin<LoopFusion> {

  // Entry point del Function Pass
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    outs() << "\n------------------------\nRunning LoopFusionPass on function: "
               << F.getName() << "\n--------------\n";

        // Recupera la loop tree della funzione
        LoopInfo &LI = AM.getResult<LoopAnalysis>(F);
        ScalarEvolution &SE = AM.getResult<ScalarEvolutionAnalysis>(F);

        // Recupero l'albero delle dipendenze e delle post-dipendenze
        DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
        PostDominatorTree &PDT = AM.getResult<PostDominatorTreeAnalysis>(F);

        // Inizia dai top-level loops
        std::vector<Loop*> topLevelLoops = LI.getTopLevelLoops();
        
        if(topLevelLoops.size() > 0)
            std::reverse(topLevelLoops.begin(), topLevelLoops.end());
            processLoopSiblings(topLevelLoops, SE, DT, PDT);


    return PreservedAnalyses::all();
  }

  private:
    bool verbose = true;

    //========================================================
    // Visita ricorsiva dei siblings
    //========================================================
    //
    // Questa funzione:
    //
    // 1. controlla i loop consecutivi allo stesso livello
    // 2. calcola i trip count per ogni coppia
    // 3. visita ricorsivamente i subloops
    //
    //========================================================
    void processLoopSiblings(ArrayRef<Loop *> Loops, ScalarEvolution &SE, DominatorTree &DT, PostDominatorTree &PDT) {
        // if (verbose) outs() << "number of loops in the function: " << Loops.size() << "\n";

        // Vengono tenuti gli indici dei loop che sono stati fusi, durante l'iterazione si controlla che l'indice che si sta per scegliere sia differente da uno in questa lista

        // Controlla coppie consecutive di siblings
        for (unsigned i = 0; i+1 < Loops.size(); ++i) {
            // if (1) outs() << "indexes: " << i << ", " << i-1 << "\n";

            Loop *L0 = Loops[i];

            Loop *L1 = Loops[i + 1];

            // Controllo che L0 abbia un solo exit block e un solo exiting block
            // Un solo exiting block
            bool L0HasOneExitingBlock = true;
            SmallVector<BasicBlock *, 4> ExitingBlocks;
            L0->getExitingBlocks(ExitingBlocks);

            if (ExitingBlocks.size() != 1){
                // Ne ha più di uno
                L0HasOneExitingBlock = false;
            }
            // Un solo exit block
            bool L0HasOneExitBlock = true;
            SmallVector<BasicBlock *, 4> ExitBlocks;
            L0->getExitBlocks(ExitBlocks);

            if (ExitBlocks.size() != 1){
                // Ne ha più di uno
                L0HasOneExitBlock = false;
            }
                

            if(verbose) {
                errs() << "Checking adjacency between:\n";
                errs() << "  L0 header: ";
                    L0->getHeader()->printAsOperand(outs(), false);
                    errs() << "\n";
                errs() << "  L1 header: ";
                    L1->getHeader()->printAsOperand(outs(), false);
                    errs() << "\n";

                if (L0HasOneExitingBlock){
                    errs() << "\tl'exiting block di L0: ";
                        L0->getExitingBlock()->printAsOperand(outs(), false);
                        errs() << "\n";
                }
                else{
                    errs() << "L0 ha più di un exiting block\n";
                }
            }

            if (areAdjacent(L0, L1)) {

                errs() << "  --> Adjacent loops found!\n";
            }
            else {

                errs() << "  --> NOT adjacent\n";
            }
            

            // CALCOLO DEL TRIP COUNT DEI LOOP
            bool sameTripCount = false;
            //A better measure is the backedge-taken count, which is the number of times any of the backedges is taken before the loop. It is one less than the trip count for executions that enter the header.
            const SCEV* tripCountL0 = SE.getBackedgeTakenCount(L0);
            const SCEV* tripCountL1 = SE.getBackedgeTakenCount(L1);
            
            
            
            
            if(verbose) {outs() << "\n---CONTROLLO TRIP COUNT---\n";}
            
            if (tripCountL0 != tripCountL1){
                outs() << "numero di esecuzioni differente\n";
            } else {
                outs() << "i loop vengono eseguiti lo stesso numero di volte" << "\n";
                sameTripCount = true;
            }


            // Controllo control flow equivalenza
            if (verbose) errs()<<"\n---CONTROLLO CONTROL FLOW ---\n";
            bool ControlFlowEquivalent = areLoopsControlFlowEquivalent(L0, L1, DT, PDT);

            if (ControlFlowEquivalent){
                outs() << "I due loop sono control flow equivalenti: se esegue uno, esegue anche l'altro\n";
            }
            else {
                outs() << "I due loop NON sono control flow equivalenti\n";
            }


        }

        // Ricorsione sui subloops
        for (Loop *L : Loops) {
            if(L->getSubLoops().size() != 0)
                processLoopSiblings(L->getSubLoops(), SE, DT, PDT);
        }
    }

    //========================================================
    // Verifica completa di adiacenza
    //========================================================
    //
    // Due casi:
    //
    // 1. Loop guarded
    // 2. Loop non guarded
    //
    //========================================================
    bool areAdjacent(Loop *L0, Loop *L1) {

        if (!L0 || !L1)
            return false;

        if(verbose) {
            outs() << "Il loop L0 è guarded? " << L0->isGuarded() << "\n";
            outs() << "Il loop L1 è guarded? " << L1->isGuarded() << "\n";
            
        }
        //----------------------------------------------------
        // CASO 1: loop guarded
        //----------------------------------------------------
        //
        // Il successore non-loop della guardia di L0
        // deve essere l'header di L1.
        //
        // Inoltre:
        // - il guard block di L1 deve contenere SOLO
        //   compare + branch
        //
        //----------------------------------------------------
        if (L0->isGuarded() && L1->isGuarded()) {

            errs() << "caso 1: i due loop sono guarded\n";
            //----------------------------------------------------
            // I due loop devono avere
            // la stessa guardia
            //----------------------------------------------------

            if (!haveSameGuard(L0, L1)){
                
                errs() << "I due loop non hanno la stessa guardia:\n\t";
                return false;
            }

            errs() << "I due loop hanno la stessa guardia\n";

            //----------------------------------------------------
            // Recupera la guardia del secondo loop
            //----------------------------------------------------
            BranchInst *GuardBI1 = L1->getLoopGuardBranch();

            if (!GuardBI1)
                return false;

            BasicBlock *GuardBB = GuardBI1->getParent();

            // Il guard block del secondo loop deve essere "pulito"
            // Verifica assenza di istruzioni intermedie
            if (!isSimpleGuardBlock(GuardBB)){
                errs() <<"Il guard block del secondo loop non è pulito e ha istruzioni intermedie\n";
                return false;
            }

            errs() << "Il guard block del secondo loop è pulito\n";

            // Verifica adiacenza CFG

            BranchInst *GuardBI0 = L0->getLoopGuardBranch();

            if (!GuardBI0)
                return false;

            
            BasicBlock *NonLoopSucc = nullptr;

            // Cerca il successore NON interno al loop L0
            for (BasicBlock *Succ : GuardBI0->successors()) {

                if (!L0->contains(Succ)) {
                    NonLoopSucc = Succ;
                    break;
                }
            }

            if (!NonLoopSucc)
                return false;

            // Deve puntare direttamente al loop successivo:
            // Il successore esterno di L0
            // deve andare direttamente a L1 -> deve puntare alla guardia di L1
            return NonLoopSucc == GuardBB;
        }

        //----------------------------------------------------
        // CASO 2: loop non guarded
        //----------------------------------------------------
        //
        // exit(L0) deve coincidere con
        // preheader(L1)
        //
        // Inoltre il preheader di L1 deve contenere
        // SOLO il branch.
        //
        //----------------------------------------------------
        if(!L0->isGuarded() && !L1->isGuarded()){

            errs() <<"caso 2: i due loop non sono guarded\n";

            // Controllo che L0 abbia un solo exit block
            bool L0HasOneExitBlock = true;
            SmallVector<BasicBlock *, 4> ExitBlocks;
            L0->getExitBlocks(ExitBlocks);

            if (ExitBlocks.size() != 1){
                // Ne ha più di uno
                L0HasOneExitBlock = false;
            }

            if (L0HasOneExitBlock == false){
                outs() << "L0 ha più di un exit block, non posso eseguire la fusione\n";
                return false;
            }

            BasicBlock *ExitBlock = L0->getExitBlock();
            if (verbose) {
                outs() << "\texit block LO: ";
                ExitBlock->printAsOperand(outs(), false);
                errs() << "\n";
            }

            BasicBlock *Preheader =
                L1->getLoopPreheader();
            
            if (!ExitBlock)
                return false;
            
            // Se il loop non ha preheader controllo l'adiacenza con l'header
            if(!Preheader) {
                Preheader=L1->getHeader();
            }

            // Verifica adiacenza CFG
            if (ExitBlock != Preheader)
                return false;

            // Verifica assenza di istruzioni intermedie nel preheader del secondo loop
            if (!isEmptyPreheader(Preheader)){
                errs() << "Ci sono istruzioni intermedie nel preheader del secondo loop\n";
                return false;
            }

            errs() << "Il preheader del secondo loop è pulito: non ci sono istruzioni intermedie\n";

            return true;
        }

        // Caso in cui ho un loop guarded e uno non guarded, non possono essere fusi
        errs() << "Ho trovato un loop guarded e uno non guarded, non possono essere fusi\n";
        return false;
    }

    //========================================================
    // Verifica che il preheader sia vuoto
    //========================================================
    //
    // Consentiamo SOLO:
    //
    // - branch terminator
    // - debug intrinsics
    //
    // Qualsiasi altra istruzione significa
    // che esiste computazione tra i loop.
    //
    //========================================================
    bool isEmptyPreheader(BasicBlock *BB) {

        Instruction *Terminator =
            BB->getTerminator();

        for (Instruction &I : *BB) {

            // Consenti il branch finale
            if (&I == Terminator)
                continue;

            // Ignora debug/pseudo instructions
            if (I.isDebugOrPseudoInst())
                continue;
            
            // Ignora le PHI
            if (isa<PHINode>(&I))
                continue;

            // Qualsiasi altra istruzione
            // rompe l'adiacenza
            return false;
        }

        return true;
    }

    //========================================================
    // Verifica che il guard block sia semplice
    //========================================================
    //
    // Consentiamo SOLO:
    //
    // - icmp/fcmp
    // - branch
    // - debug instructions
    //
    // Se esistono altre istruzioni:
    // => computazione tra i loop
    //
    //========================================================
    bool isSimpleGuardBlock(BasicBlock *BB) {

        for (Instruction &I : *BB) {

            // Ignora debug
            if (I.isDebugOrPseudoInst())
                continue;

            // Ignora le PHI
            if (isa<PHINode>(&I))
                continue;

            // Consenti branch
            if (isa<BranchInst>(&I))
                continue;

            // Consenti confronti
            if (isa<ICmpInst>(&I))
                continue;

            if (isa<FCmpInst>(&I))
                continue;

            // Tutto il resto non è consentito
            return false;
        }

        return true;
    }

    //========================================================
    // Verifica che due loop guarded
    // abbiano la stessa guardia
    //========================================================
    //
    // Due loop guarded hanno la stessa guardia se:
    //
    // 1. hanno lo stesso branch di guardia
    //
    // oppure
    //
    // 2. il branch usa la stessa condition
    //
    //========================================================
    bool haveSameGuard(Loop *L0, Loop *L1) {
        if(verbose) outs() << "\n---CONTROLLO GUARDIE---\n";
        
        // Entrambi devono essere guarded
        if (!L0->isGuarded() || !L1->isGuarded())
            return false;

        //----------------------------------------------------
        // Recupera i branch di guardia
        //----------------------------------------------------

        BranchInst *GuardBI0 =
            L0->getLoopGuardBranch();

        BranchInst *GuardBI1 =
            L1->getLoopGuardBranch();

        if (!GuardBI0 || !GuardBI1)
            return false;

        //----------------------------------------------------
        // Caso 1:
        // stesso identico BranchInst
        //----------------------------------------------------

        if (GuardBI0 == GuardBI1)
            return true;

        //----------------------------------------------------
        // Caso 2:
        // stessa condition
        //----------------------------------------------------

        Value *Cond0 = GuardBI0->getCondition();
        Value *Cond1 = GuardBI1->getCondition();
        
        if(verbose) { outs() << "\tcondizione 1: "; Cond0->print(outs()); 
                outs() << "\n\tcondizione 2: "; Cond1->print(outs()); outs() << "\n";}
            
        //----------------------------------------------------
        // Caso 3:
        // condition equivalenti
        //----------------------------------------------------
        //cast a istruzione delle condizioni
        if(ICmpInst* CondInst0 = dyn_cast<ICmpInst>(Cond0)) {
            if(ICmpInst* CondInst1 = dyn_cast<ICmpInst>(Cond1)) {

                // stesso operando
                if(CondInst0->getPredicate() == CondInst1->getPredicate()) {
                    
                    //stessi registri -> sono equivalenti
                    if((CondInst0->getOperand(0) == CondInst1->getOperand(0)) &&
                    (CondInst0->getOperand(1) == CondInst1->getOperand(1))) {
                        
                        if(verbose){outs() << "corrispondono\n";}
                        
                        return true;
                    }
                }
                //operando complementare all'altro (>= e <=)
                if(CondInst0->getPredicate() == CondInst1->getSwappedPredicate()) {
                    
                    //registri apeculari -> sono equivalenti
                    if((CondInst0->getOperand(0) == CondInst1->getOperand(1)) &&
                    (CondInst0->getOperand(1) == CondInst1->getOperand(0))) {
                        
                        if(verbose){outs() << "sono equivalenti\n";}
                        
                        return true;
                    }
                }
            }
        }

        //----------------------------------------------------
        // Guardie differenti
        //----------------------------------------------------

        return false;
    }

    //========================================================
    // Controllo che abbiano il control flow equivalente
    // Analisi di dominanza e postdominanza
    // I due loop devono essere control flow equivalenti:
    // quando uno dei due loop esegue, deve eseguire anche l'altro
    //========================================================
    bool areLoopsControlFlowEquivalent(Loop *L0, Loop *L1, DominatorTree &DT, PostDominatorTree &PDT) {
        BasicBlock *HeaderL0 = L0->getHeader();
        BasicBlock *HeaderL1 = L1->getHeader();

        return DT.dominates(HeaderL0, HeaderL1) && PDT.dominates(HeaderL1, HeaderL0);
    }


    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getLoopFusionPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "LoopFusion", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "my-loop-fusion") {
                    FPM.addPass(LoopFusion());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize LoopFusion when added to the pass pipeline on the
// command line, i.e. via '-passes=loop-fusion'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getLoopFusionPluginInfo();
}