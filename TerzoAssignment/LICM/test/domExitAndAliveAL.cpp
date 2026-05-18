
int dominatesExitesAliveAL() {
    int a = 3;
    int b = 4;

    int x = 0;
    int y = 0;

    int i = 0;
    do {
        int z = a+b;
        
        x = a*7 + b;
        y = x+2;
    }while(i < 100);

    int j = x + y;

    return 0;
}