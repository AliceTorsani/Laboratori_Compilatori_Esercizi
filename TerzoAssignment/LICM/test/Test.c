#include <stdio.h>

int global = 5;

// funzione senza effetti collaterali
int pure_function(int x) {
    return x * 2;
}

// funzione con effetti collaterali
int impure_function(int *p) {
    (*p)++;
    return *p;
}

int main() {

    int a = 10;
    int b = 20;
    int c = 0;
    int d = 3;

    int arr[100];

    for (int i = 0; i < 100; i++) {

        // Caso 1: completamente invariant (costanti + variabili fuori loop)
        int x = a + b;

        // Caso 2: invariant dipendente da altra invariant
        int y = x * 2;

        // Caso 3: NON invariant (dipende da i)
        int z = x + i;

        // Caso 4: chiamata pura → teoricamente invariant
        int p = pure_function(a);

        // Caso 5: chiamata con side effects → NON invariant
        int q = impure_function(&c);

        // Caso 6: accesso memoria (non invariant)
        int m = arr[0];

        // Caso 7: store → mai invariant
        arr[i] = x + y;

        // Caso 8: combinazione (invariant)
        int w = y + d;

        c += z + q + w + p + m;
    }

    printf("Result: %d\n", c);
    return 0;
}