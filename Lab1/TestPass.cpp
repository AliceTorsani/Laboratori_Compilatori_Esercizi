//=============================================================================
// FILE:
//    TestPass.cpp
//
// DESCRIPTION:
//    Visits all functions in a module and prints their names. Strictly speaking, 
//    this is an analysis pass (i.e. //    the functions are not modified). However, 
//    in order to keep things simple there's no 'print' method here (every analysis 
//    pass should implement it).
//
// USAGE:
//    New PM
//      opt -load-pass-plugin=<path-to>libTestPass.so -passes="test-pass" `\`
//        -disable-output <input-llvm-file>
//
//
// License: MIT
//=============================================================================
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

//-----------------------------------------------------------------------------
// TestPass implementation
//-----------------------------------------------------------------------------
// No need to expose the internals of the pass to the outside world - keep
// everything in an anonymous namespace.
namespace {


// New PM implementation
struct TestPass: PassInfoMixin<TestPass> {
  // Main entry point, takes IR unit to run the pass on (&F) and the
  // corresponding pass manager (to be queried if need be)
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

  	errs() << "Function: " << F.getName() << '\n';

    // 2. Numero argomenti
    errs() << "Args: " << F.arg_size();
    if (F.isVarArg())
      errs() << "+*";
    errs() << "\n";

    // 3. Numero chiamate (approccio sbagliato)
    int callCount = 0;
    Module *M = F.getParent();

    for (auto &Func : *M) {
      for (auto &BB : Func) {
        for (auto &I : BB) {
          if (auto *call = dyn_cast<CallBase>(&I)) {
            if (call->getCalledFunction() == &F)
              callCount++;
          }
        }
      }
    }

    errs() << "Calls (approccio errato): " << callCount << "\n";

    // 3. Numero chiamate (approccio giusto)
    int callInModuleCount = 0;
    for (auto &BB : F){
      for (auto &I : BB){
        if (auto *call = dyn_cast<CallBase>(&I)) {
          Function *called = call->getCalledFunction();
          if (called) { //evito i nullpointer (nullptr)
            if (!called->isDeclaration()) {
              callInModuleCount++;
            }
          }
          //if (call->getCalledFunction()->isDeclaration() == false) //se la funzione chiamata appartiene al modulo la conto
          //se non è una declaration allora appartiene al modulo e la conto
          //callInModuleCount++;
        }
      }
    }

    errs() << "Calls (approccio giusto): " << callInModuleCount << "\n";

    // 4. Basic Blocks
    errs() << "BasicBlocks: " << F.size() << "\n";

    // 5. Istruzioni
    int instCount = 0;
    for (auto &BB : F)
      for (auto &I : BB)
        instCount++;

    errs() << "Instructions: " << instCount << "\n";

    errs() << "----------------------\n";

  	return PreservedAnalyses::all();
}


  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};
} // namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getTestPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "TestPass", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "test-pass") {
                    FPM.addPass(TestPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize TestPass when added to the pass pipeline on the
// command line, i.e. via '-passes=test-pass'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getTestPassPluginInfo();
}
