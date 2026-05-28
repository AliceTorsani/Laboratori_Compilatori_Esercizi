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

using namespace llvm;

namespace {

// New PM implementation
struct LoopFusion: PassInfoMixin<LoopFusion> {

  // Entry point del Function Pass
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    errs() << "Running LoopFusionPass on function: "
               << F.getName() << "\n";

        // Recupera la loop tree della funzione
        LoopInfo &LI = AM.getResult<LoopAnalysis>(F);

        // Inizia dai top-level loops
        processLoopSiblings(LI.getTopLevelLoops());


    return PreservedAnalyses::all();
  }

  private:

    //========================================================
    // Visita ricorsiva dei siblings
    //========================================================
    //
    // Questa funzione:
    //
    // 1. controlla i loop consecutivi allo stesso livello
    // 2. visita ricorsivamente i subloops
    //
    //========================================================
    void processLoopSiblings(ArrayRef<Loop *> Loops) {

        // Controlla coppie consecutive di siblings
        for (unsigned i = 0; i + 1 < Loops.size(); ++i) {

            Loop *L0 = Loops[i];
            Loop *L1 = Loops[i + 1];

            errs() << "Checking adjacency between:\n";
            errs() << "  L0 header: ";
                   L0->getHeader()->printAsOperand(outs(), false);
                   errs() << "\n";
            errs() << "  L1 header: ";
                   L1->getHeader()->printAsOperand(outs(), false);
                   errs() << "\n";

            if (areAdjacent(L0, L1)) {

                errs() << "  --> Adjacent loops found!\n";
            }
            else {

                errs() << "  --> NOT adjacent\n";
            }
        }

        // Ricorsione sui subloops
        for (Loop *L : Loops) {
            processLoopSiblings(L->getSubLoops());
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

            BranchInst *GuardBI1 = L1->getLoopGuardBranch();

            if (!GuardBI1)
                return false;

            BasicBlock *GuardBB = GuardBI1->getParent();

            // Il guard block del secondo loop deve essere "pulito"
            // Verifica assenza di istruzioni intermedie
            if (!isSimpleGuardBlock(GuardBB))
                return false;

            // Verifica adiacenza CFG

            BranchInst *GuardBI = L0->getLoopGuardBranch();

            if (!GuardBI)
                return false;

            
            BasicBlock *NonLoopSucc = nullptr;

            // Cerca il successore NON interno al loop
            for (BasicBlock *Succ : GuardBI->successors()) {

                if (!L0->contains(Succ)) {
                    NonLoopSucc = Succ;
                    break;
                }
            }

            if (!NonLoopSucc)
                return false;

            // Deve puntare direttamente al loop successivo
            return NonLoopSucc == L1->getHeader();
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

        BasicBlock *ExitBlock = L0->getExitBlock();

        BasicBlock *Preheader =
            L1->getLoopPreheader();

        if (!ExitBlock || !Preheader)
            return false;

        // Verifica adiacenza CFG
        if (ExitBlock != Preheader)
            return false;

        // Verifica assenza di istruzioni intermedie nel preheader del secondo loop
        if (!isEmptyPreheader(Preheader))
            return false;

        return true;
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
                  if (Name == "loop-fusion") {
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