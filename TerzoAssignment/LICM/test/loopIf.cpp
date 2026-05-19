int provaAssignement(int primaVar) {
    int q = 5;
    int z = q+5;
    int a = 10;
    int b = 20;
    int c = 0;
    int d = 3;
    int pseudo = 0;

    do {
        pseudo++;
        
        //      negazione, tradotto in sub 0, primaVar
        int negativo = -primaVar;
        // test loopInvariant
        int x = a+b;
        float varPerNegative = x/a;
        int z = a+negativo;
        c = x + z;
        
        if(primaVar > 2) {
            int testComplementare = a+d;
        }
    
      } while(pseudo < 100);
    
    bool vero = true;
    bool falso = !vero;

    return q+pseudo+primaVar;
}

