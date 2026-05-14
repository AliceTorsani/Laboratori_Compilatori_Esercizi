int provaAssignement(int primaVar) {
    int q = 5;
    int z = q+5;
    int a = 10;
    int b = 20;
    int c = 0;
    int d = 3;
    int pseudo = primaVar;

    while(pseudo < 100){
        pseudo++;

        //TEST: ricerca di operazioni unarie
        //      aliasing, viene rilassato
        int alias = pseudo;
        
        if(primaVar > 2) {
            //      aliasing
            int copia = primaVar;
            //      operatori +=, tradotti in add
            copia +=2;
            primaVar += copia;
        }
        //      negazione, tradotto in sub 0, primaVar
        int negativo = -primaVar;
        // test loopInvariant
        int x = a+b;
        float varPerNegative = x/a;
        int y = a+alias;
        int z = a+negativo;
        c = x + y + z;
/*
3:                                                ; preds = %11, %1
  %.01 = phi i32 [ %0, %1 ], [ %6, %11 ]
  %.0 = phi i32 [ %0, %1 ], [ %.1, %11 ]
  %4 = icmp slt i32 %.01, 100
  br i1 %4, label %5, label %21

5:                                                ; preds = %3
  %6 = add nsw i32 %.01, 1 ;pseudo++ ;viene rilassato alias=pseudo
  %7 = icmp sgt i32 %.0, 2
  br i1 %7, label %8, label %11

8:                                                ; preds = %5
  %9 = add nsw i32 %.0, 2 ;copia+=2 ;viene rilassato copia=primavar
  %10 = add nsw i32 %.0, %9 ;primaVar+=copia
  br label %11

11:                                               ; preds = %8, %5
  %.1 = phi i32 [ %10, %8 ], [ %.0, %5 ]
  %12 = sub nsw i32 0, %.1 ;negativo = 0-primaVar;
  %13 = add nsw i32 10, 20 ;x=a+b
  %14 = sdiv i32 %13, 10
  %15 = sitofp i32 %14 to float
  %16 = add nsw i32 10, %6 ;y=a+alias=>a+pseudo
  %17 = add nsw i32 10, %12 ;z=a+negativo
  %18 = add nsw i32 %13, %16
  %19 = add nsw i32 %18, %17
  %20 = fneg float %15 ; operazione unaria
  br label %3, !llvm.loop !6

21:                                               ; preds = %3
  %22 = trunc i8 1 to i1
  %23 = xor i1 %22, true
  %24 = zext i1 %23 to i8
  %25 = add nsw i32 5, %.01
  %26 = add nsw i32 %25, %.0
  ret i32 %26
}
*/


    }
    
    bool vero = true;
    bool falso = !vero;

    return q+pseudo+primaVar;
}


int icmTest(int alias) {

    int a = 10;
    int b = 20;
    int c = 0;
    int d = 3;

    int arr[100];

    // i=0
    for (int i=alias; i<100; i++) {

        // // Caso 1: completamente invariant (costanti + variabili fuori loop)
        int x = a + b;

        // // Caso 2: invariant dipendente da altra invariant
        int y = x * 2;

        // // Caso 3: NON invariant (dipende da i)
        int z = x + i;

        // // Caso 6: accesso memoria (non invariant)
        int m = arr[0];

        // // Caso 7: store → mai invariant
        arr[i] = x + y;

        // // Caso 8: combinazione (invariant)
        int w = y + d;        
    }

    return 0;
}