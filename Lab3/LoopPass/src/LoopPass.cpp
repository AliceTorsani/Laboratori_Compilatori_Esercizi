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
//opt -S -load-pass-plugin ../build/libLoopPass.so -p -loop-pass Test.m2r.ll -o Test.optimized.ll
struct LoopPass: PassInfoMixin<LoopPass> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    outs()<<"Eseguito passo LoopPass"<<"\n";

    LoopInfo &LI = AM.getResult<LoopAnalysis>(F);

    // 1. Verifica presenza loop: se non ci sono loop → esci
    if (LI.empty()) {
      outs()<<"Non ci sono loop, esco"<<"\n";
      return PreservedAnalyses::all();
    }

    // 2. Scorrere tutti i basic block con iteratori: scorro i basic block e verifico header
    for (Function::iterator BB_it = F.begin(); BB_it != F.end(); ++BB_it) {
      BasicBlock &BB = *BB_it;

      if (LI.isLoopHeader(&BB)) {
        errs() << "Loop header trovato:\n";
        BB.print(errs());  // stampa tutto il blocco
      }
    }

    // Funzione per visitare loop (punto 3)
    std::function<void(Loop*)> visitLoop = [&](Loop *L) {

      // a) Verifica forma normale
      if (L->isLoopSimplifyForm()) {
        errs() << "Loop in forma normale\n";
      } else {
        errs() << "Loop NON in forma normale\n";
      }

      // b) Header → funzione → stampa CFG (solo BB)
      BasicBlock *Header = L->getHeader();
      Function *Func = Header->getParent(); // richiesto dal testo

      errs() << "CFG della funzione " << Func->getName() << ":\n";

      for (Function::iterator BB_it = Func->begin(); BB_it != Func->end(); ++BB_it) {
        BasicBlock &BB = *BB_it;
        BB.print(errs());
      }

      // c) Blocchi del loop (con iteratori)
      errs() << "Blocchi del loop:\n";

      for (Loop::block_iterator BI = L->block_begin(); BI != L->block_end(); ++BI) {
        BasicBlock *BB = *BI;
        BB->print(errs());
      }

      // Subloop: solo segnalazione header
      for (Loop::iterator SubL = L->begin(); SubL != L->end(); ++SubL) {
        Loop *SL = *SubL;
        BasicBlock *SubHeader = SL->getHeader();

        errs() << "Questo è l'header di un subloop (blocco di inizio subloop):\n";
        SubHeader->print(errs());
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