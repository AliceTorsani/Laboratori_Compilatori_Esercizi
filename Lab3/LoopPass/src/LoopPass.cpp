#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/CFG.h"

using namespace llvm;

namespace {

// New PM implementation
//Invocare il passo nella cartella /test nel seguente modo:
//opt -S -load-pass-plugin ../build/libLoopPass.so -p -loop-pass Loop.m2r.ll -o Loop.optimized.ll
struct LoopPass: PassInfoMixin<LoopPass> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    outs()<<"Eseguito passo LoopPass"<<"\n";

    LoopInfo &LI = AM.getResult<LoopAnalysis>(F);

    // 1. Verifica presenza loop
    if (LI.empty()) {
      return PreservedAnalyses::all();
    }

    // 2. Scorrere tutti i basic block con iteratori
    for (Function::iterator BB_it = F.begin(); BB_it != F.end(); ++BB_it) {
      BasicBlock &BB = *BB_it;

      if (LI.isLoopHeader(&BB)) {
        errs() << "Loop header trovato: " << BB.getName() << "\n";
      }
    }

    // Funzione ricorsiva per visitare loop (anche annidati)
    std::function<void(Loop*)> visitLoop = [&](Loop *L) {

      // a) Verifica forma normale
      if (L->isLoopSimplifyForm()) {
        errs() << "Loop in forma normale\n";
      } else {
        errs() << "Loop NON in forma normale\n";
      }

      // b) Header → funzione → stampa CFG
      BasicBlock *Header = L->getHeader();
      Function *Func = Header->getParent(); // richiesto dal testo

      errs() << "CFG della funzione " << Func->getName() << ":\n";

      for (Function::iterator BB_it = Func->begin(); BB_it != Func->end(); ++BB_it) {
        BasicBlock &BB = *BB_it;

        errs() << BB.getName() << " -> ";

        for (succ_iterator SI = succ_begin(&BB); SI != succ_end(&BB); ++SI) {
          errs() << (*SI)->getName() << " ";
        }

        errs() << "\n";
      }

      // c) Blocchi del loop (con iteratori)
      errs() << "Blocchi del loop:\n";

      for (Loop::block_iterator BI = L->block_begin(); BI != L->block_end(); ++BI) {
        BasicBlock *BB = *BI;
        errs() << BB->getName() << "\n";
      }

      // Visita sotto-loop
      for (Loop::iterator SubL = L->begin(); SubL != L->end(); ++SubL) {
        visitLoop(*SubL);
      }
    };

    // 3. Scorrere tutti i loop (top-level)
    for (LoopInfo::iterator L_it = LI.begin(); L_it != LI.end(); ++L_it) {
      visitLoop(*L_it);
    }



    return PreservedAnalyses::all();
  }
    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getLoopPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "LoopPass", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "-loop-pass") {
                    FPM.addPass(LoopPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize LoopPass when added to the pass pipeline on the
// command line, i.e. via '-passes=-loop-pass'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getLoopPassPluginInfo();
}