#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

// New PM implementation
struct MultiOpt: PassInfoMixin<MultiOpt> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    outs()<<"eseguito passo di multi-instruction optimization"<<"\n";



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