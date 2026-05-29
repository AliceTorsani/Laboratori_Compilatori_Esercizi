#include <stdio.h>

// CASO : POSITIVO
// I loop sono adiacenti
// Nessun blocco extra tra uscita L0 ed entry L1.

void test_fusion_success(int *A, int *B, int *C, int N) {
    // Loop 0
    for (int i = 0; i < N; i++) {
        A[i] = B[i] * 2;
    }

    // Loop 1
    for (int i = 0; i < N; i++) {
        C[i] = A[i] + 10;
    }
}

// CASO : NEGATIVO (Fallisce l'adiacenza)
// I loop NON sono adiacenti.
void test_fusion_fail_adjacency(int *A, int *B, int *C, int N) {
    // Loop 0
    for (int i = 0; i < N; i++) {
        A[i] = B[i] * 2;
    }

    // Questa singola istruzione genera un Basic Block intermedio
    // tra l'uscita del primo loop e il preheader del secondo.
    A[0] = 0; 

    // Loop 1
    for (int i = 0; i < N; i++) {
        C[i] = A[i] + 10;
    }
}

int main(){

    int N = 50;
    int A[N];
    int B[N];
    int C[N];

    test_fusion_success(A, B, C, N);
    test_fusion_fail_adjacency(A, B, C, N);

    return 0;

}

