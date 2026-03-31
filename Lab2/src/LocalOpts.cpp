#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

// New PM implementation
struct LocalOpts: PassInfoMixin<LocalOpts> {

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {

    for (auto Iter = F.begin(); Iter != F.end(); ++Iter) {
      BasicBlock &B = *Iter;
       // Preleviamo le prime due istruzioni del BB
      Instruction &Inst1st = *B.begin(), &Inst2nd = *(++B.begin());

      // L'indirizzo della prima istruzione deve essere uguale a quello del 
      // primo operando della seconda istruzione (per costruzione dell'esempio)
      assert(&Inst1st == Inst2nd.getOperand(0));

      // Stampa la prima istruzione
      outs() << "PRIMA ISTRUZIONE: " << Inst1st << "\n";
      // Stampa la prima istruzione come operando
      outs() << "COME OPERANDO: ";
      Inst1st.printAsOperand(outs(), false);
      outs() << "\n";

      // User-->Use-->Value
      outs() << "I MIEI OPERANDI SONO:\n";
      for (auto Iter = Inst1st.op_begin(); Iter != Inst1st.op_end(); ++Iter) {
        Value *Operand = *Iter;

        if (Argument *Arg = dyn_cast<Argument>(Operand)) {
          outs() << "\t" << *Arg << ": SONO L'ARGOMENTO N. " << Arg->getArgNo() 
  	         <<" DELLA FUNZIONE " << Arg->getParent()->getName()
                 << "\n";
        }
        if (ConstantInt *C = dyn_cast<ConstantInt>(Operand)) {
          outs() << "\t" << *C << ": SONO UNA COSTANTE INTERA DI VALORE " << C->getValue()
                 << "\n";
        }
      }

      outs() << "LA LISTA DEI MIEI USERS:\n";
      for (auto Iter = Inst1st.user_begin(); Iter != Inst1st.user_end(); ++Iter) {
        //outs() << "\t" << *(dyn_cast<Instruction>(*Iter)) << "\n";
	User *U = *Iter;
        outs() << "\t" << *U << "\n";
      }

      // Qual è la differenza tra gli USERS e gli USES?
      // Prova a vedere cosa succede se in Foo.ll la seconda istruzione diventa
      // %4 = mul nsw i32 %3, %3
      outs() << "E DEI MIEI USI:\n";
      for (auto Iter = Inst1st.use_begin(); Iter != Inst1st.use_end(); ++Iter) {
        //outs() << "\t" << *(dyn_cast<Instruction>(Iter->getUser())) << "\n";
	Use &U = *Iter;
        outs() << "\t" << *U.getUser() << "@operand" << U.getOperandNo() << "\n";
      }

      // Manipolazione delle istruzioni
      Instruction *NewInst = BinaryOperator::Create(
          Instruction::Add, Inst1st.getOperand(0), Inst1st.getOperand(0));

      NewInst->insertAfter(&Inst1st);
      // Si possono aggiornare le singole references separatamente?
      // Controlla la documentazione e prova a rispondere.
      Inst1st.replaceAllUsesWith(NewInst);
      
      //sono dentro il ciclo sui basic block
      //esercizio2 (strength reduction)
      for (auto IterInst = B.begin(); IterInst != B.end(); ) {
        Instruction *I = &*IterInst++;
        
        // Controlla se è una BinaryOperator
        if (auto *BinOp = dyn_cast<BinaryOperator>(I)) {

          // Controlla se è una MUL
          if (BinOp->getOpcode() == Instruction::Mul) {

            Value *Op0 = BinOp->getOperand(0);
            Value *Op1 = BinOp->getOperand(1);

            ConstantInt *C = nullptr;
            Value *OtherOp = nullptr;

            // Trova la costante
            if ((C = dyn_cast<ConstantInt>(Op0))) {
              OtherOp = Op1;
            } else if ((C = dyn_cast<ConstantInt>(Op1))) {
              OtherOp = Op0;
            }

            // Se è una potenza di 2
            if (C && C->getValue().isPowerOf2()) {

              unsigned ShiftAmount = C->getValue().logBase2();

              // Crea la SHL
              Instruction *Shl = BinaryOperator::Create(
                  Instruction::Shl,
                  OtherOp,
                  ConstantInt::get(C->getType(), ShiftAmount)
              );

              // Inserisci subito dopo la MUL
              Shl->insertAfter(BinOp);

              // Sostituisci tutti gli usi della MUL
              BinOp->replaceAllUsesWith(Shl);

              // (opzionale debug)
              outs() << "Sostituita MUL con SHL: ";
              outs() << *Shl << "\n";
            }
          }
        }
      }


    }


    return PreservedAnalyses::all();
  }
    static bool isRequired() { return true; }
};  
}//namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getLocalOptsPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "LocalOpts", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "local-opts") {
                    FPM.addPass(LocalOpts());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize LocalOpts when added to the pass pipeline on the
// command line, i.e. via '-passes=local-opts'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getLocalOptsPluginInfo();
}
