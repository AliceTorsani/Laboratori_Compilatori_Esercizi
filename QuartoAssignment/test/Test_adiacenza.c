#include <stdio.h>

#define N 128

//====================================================
// CASE 1
// NON GUARDED
// ADIACENT
//
// Deve essere FONDIBILE
//====================================================
void adjacent_plain(int *A, int *B, int *C) {

    for (int i = 0; i < N; i++) {
        A[i] = B[i] + 1;
    }

    for (int i = 0; i < N; i++) {
        C[i] = A[i] * 2;
    }
}

//====================================================
// CASE 2
// NON GUARDED
// NON ADJACENT
//
// Statement tra i loop
//
// NON fondibile
//====================================================
void non_adjacent_statement(int *A, int *B, int *C) {

    for (int i = 0; i < N; i++) {
        A[i] = B[i];
    }

    int x = 7;

    for (int i = 0; i < N; i++) {
        C[i] = A[i] + x;
    }
}

//====================================================
// CASE 3
// NON GUARDED
// PREHEADER SPORCO
//
// computation nel preheader
//
// NON fondibile
//====================================================
void dirty_preheader(int *A, int *B, int *C, int n) {

    for (int i = 0; i < n; i++) {
        A[i] = B[i];
    }

    int t = n * 2;

    for (int i = 0; i < n; i++) {
        C[i] = A[i] + t;
    }
}

//====================================================
// CASE 4
// GUARDED
// STESSA GUARDIA
// GUARDIA PULITA
//
// Deve essere FONDIBILE
//====================================================
void guarded_same_guard(int *A, int *B, int n) {

    if (n > 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i] + 1;
        }

        for (int i = 0; i < n; i++) {
            B[i] = A[i] * 2;
        }
    }
}

//====================================================
// CASE 5
// GUARDED
// GUARDIE DIVERSE
//
// NON fondibile
//====================================================
void guarded_different_guards(int *A, int *B, int n) {

    if (n > 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i];
        }
    }

    if (n > 1) {

        for (int i = 0; i < n; i++) {
            B[i] = A[i];
        }
    }
}

//====================================================
// CASE 6
// GUARDED
// GUARD BLOCK SPORCO
//
// computation nella guardia
//
// NON fondibile
//====================================================
void guarded_dirty_guard(int *A, int *B, int n) {

    int t = n * 4;

    if (t > 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i];
        }

        for (int i = 0; i < n; i++) {
            B[i] = A[i];
        }
    }
}

//====================================================
// CASE 7
// GUARDED
// BASIC BLOCK INTERMEDIO
//
// NON fondibile
//====================================================
void guarded_intermediate_block(int *A, int *B, int n) {

    if (n > 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i];
        }
    }

    int x = 42;

    if (n > 0) {

        for (int i = 0; i < n; i++) {
            B[i] = A[i] + x;
        }
    }
}

//====================================================
// CASE 8
// NESTED LOOP SIBLINGS
//
// I due inner loops
// devono essere siblings fondibili
//====================================================
void nested_siblings(int *A, int *B, int *C) {

    for (int k = 0; k < 10; k++) {

        for (int i = 0; i < N; i++) {
            A[i] = B[i];
        }

        for (int i = 0; i < N; i++) {
            C[i] = A[i];
        }
    }
}

//====================================================
// CASE 9
// NESTED MA NON SIBLINGS
//
// NON devono essere considerati
//====================================================
void nested_non_siblings(int *A, int *B) {

    for (int i = 0; i < N; i++) {

        for (int j = 0; j < N; j++) {
            A[j] = B[j];
        }
    }

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

//====================================================
// CASE 10
// SINGLE EXIT REQUIRED
//
// break interno
//
// utile per testare getExitBlock()
//====================================================
void multiple_exit_loop(int *A, int *B, int n) {

    for (int i = 0; i < n; i++) {

        if (i == 10)
            break;

        A[i] = B[i];
    }

    for (int i = 0; i < n; i++) {
        B[i] = A[i];
    }
}

//====================================================
// CASE 11
// LOAD/STORE dipendenti
//
// ancora adiacenti nel CFG
//
// utile per future dependence analysis
//====================================================
void dependent_loops(int *A, int *B) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

//====================================================
// CASE 12
// COMPLETAMENTE FONDIBILE
//
// caso ideale finale
//====================================================
void perfectly_fusible(int *A, int *B, int *C, int n) {

    if (n > 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i] + 1;
        }

        for (int i = 0; i < n; i++) {
            C[i] = A[i] * 3;
        }
    }
}

int main() {

    int A[N];
    int B[N];
    int C[N];

    adjacent_plain(A, B, C);

    non_adjacent_statement(A, B, C);

    dirty_preheader(A, B, C, N);

    guarded_same_guard(A, B, N);

    guarded_different_guards(A, B, N);

    guarded_dirty_guard(A, B, N);

    guarded_intermediate_block(A, B, N);

    nested_siblings(A, B, C);

    nested_non_siblings(A, B);

    multiple_exit_loop(A, B, N);

    dependent_loops(A, B);

    perfectly_fusible(A, B, C, N);

    return 0;
}