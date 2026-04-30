#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Dominators.h"
#include <sstream>
#include <string>

using namespace llvm;

namespace {

// New PM implementation
// Eseguire il passo nella cartella /test con il seguente comando:
// opt -S -load-pass-plugin ../build/libDomTreePass.so -p dom-tree-pass Test.m2r.ll -o Test.optimized.ll
struct DomTreePass: PassInfoMixin<DomTreePass> {

    void printDomTree(DomTreeNode *Node, int Depth = 0, bool IsLast = true) {
    if (!Node) return;

    BasicBlock *BB = Node->getBlock();

    // indentazione "strutturata"
    // indentazione per visualizzare l'albero
    for (int i = 0; i < Depth; i++)
      errs() << "│   ";

    // ramo dell'albero
    if (Depth > 0) {
        if (IsLast)
            errs() << "└── ";
        else
            errs() << "├── ";
    }

    errs() << "BasicBlock:\n";

    // stampa completa del blocco
    //BB->print(errs());

    // stampa del blocco con indentazione interna
    std::string BBStr;
    raw_string_ostream RSO(BBStr);
    BB->print(RSO);

    std::istringstream ISS(RSO.str());
    std::string Line;

    while (std::getline(ISS, Line)) {
        for (int i = 0; i < Depth + 1; i++) {
            errs() << "│   ";
        }
        errs() << Line << "\n";
    }

    errs() << "\n";

    // figli nel dominator tree
    unsigned NumChildren = Node->getNumChildren();
    unsigned i = 0;

    for (auto *Child : Node->children()) {
      bool ChildIsLast = (i == NumChildren - 1);  
      printDomTree(Child, Depth + 1, ChildIsLast);
      i++;
    }
  }

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {

    outs()<<"Eseguito passo DominatorTreePass"<<"\n";

    DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);

    errs() << "Dominator Tree della funzione: " << F.getName() << "\n";

    DomTreeNode *Root = DT.getRootNode();

    printDomTree(Root);


    return PreservedAnalyses::all();
  }
    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getDomTreePassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "DomTreePass", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "dom-tree-pass") {
                    FPM.addPass(DomTreePass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize DomTreePass when added to the pass pipeline on the
// command line, i.e. via '-passes=dom-tree-pass'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getDomTreePassPluginInfo();
}