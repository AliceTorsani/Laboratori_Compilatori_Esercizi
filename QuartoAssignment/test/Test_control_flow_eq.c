#include <stdio.h>

// L0 esegue ⇒ L1 esegue
// L1 esegue ⇒ L0 esegue
// I due loop sono control flow equivalenti
void cfe_positive_always(int *A, int *B, int N) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

// I due loop sono control flow equivalenti
void cfe_positive_same_guard(int *A, int *B, int N) {

    if (N > 0) {

        for (int i = 0; i < N; i++) {
            A[i] = i;
        }

        for (int i = 0; i < N; i++) {
            B[i] = A[i];
        }
    }
}

// I due loop sono control flow equivalenti
void cfe_positive_do_while(int *A, int *B, int N) {

    if (N > 0) {

        int i = 0;

        do {
            A[i] = i;
            i++;
        } while (i < N);

        int j = 0;

        do {
            B[j] = A[j];
            j++;
        } while (j < N);
    }
}

// L1 può essere eseguito senza L0
// Non sono control flow equivalenti
void cfe_negative_first_guarded(int *A, int *B, int N) {

    if (N > 0) {

        for (int i = 0; i < N; i++) {
            A[i] = i;
        }
    }

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

// Uno può eseguire senza l'altro
// Non sono control flow equivalenti
void cfe_negative_different_guards(
    int *A,
    int *B,
    int N,
    int M) {

    if (N > 0) {

        for (int i = 0; i < N; i++) {
            A[i] = i;
        }
    }

    if (M > 0) {

        for (int i = 0; i < M; i++) {
            B[i] = i;
        }
    }
}

// Il primo loop esegue sempre.
// Il secondo può essere saltato tramite: return
// L0 esegue, L1 no
// Non sono control flow equivalenti
void cfe_negative_intermediate_if(
    int *A,
    int *B,
    int N) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    if (A[0] < 0)
        return;

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

// Non sono control flow equivalenti
void cfe_negative_break(
    int *A,
    int *B,
    int N) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    if (N == 5)
        return;

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

// esegue L0 oppure L1, mai entrambi
// Non sono control flow equivalenti
void cfe_negative_if_else(
    int *A,
    int *B,
    int N) {

    if (N > 0) {

        for (int i = 0; i < N; i++) {
            A[i] = i;
        }

    } else {

        for (int i = 0; i < 10; i++) {
            B[i] = i;
        }
    }
}

int main(){

    int N = 20;
    int M = 10;
    int A[N];
    int B[N];

    cfe_positive_always(A, B, N);
    cfe_positive_same_guard(A, B, N);
    cfe_positive_do_while(A, B, N);
    cfe_negative_first_guarded(A, B, N);
    cfe_negative_different_guards(A, B, N, M);
    cfe_negative_intermediate_if(A, B, N);
    cfe_negative_break(A, B, N);
    cfe_negative_if_else(A, B, N);

    return 0;

}