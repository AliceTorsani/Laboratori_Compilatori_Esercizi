#include <stdio.h>

#define N 128

//====================================================
// CASE 1
// NON GUARDED
// ADIACENT
//
// Deve essere FONDIBILE
//====================================================
void adjacent_plain(int *A, int *B, int *C, int n) {

    for (int i = 0; i < n; i++) {
        A[i] = B[i] + 1;
    }

    for (int i = 0; i < n; i++) {
        C[i] = A[i] * 2;
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
    B[0] = 3;

    for (int i = 0; i < n; i++) {
        C[i] = A[i] + t;
    }
}

//====================================================
// CASE 4
// NON GUARDED
//
// Deve essere FONDIBILE
//====================================================
void guarded_same_guard(int *A, int *B, int n) {

    if (n < 0) {

        for (int i = 0; i < n; i++) {
            A[i] = B[i] + 1;
        }

        for (int i = 0; i < n; i++) {
            B[i] = A[i] * 2;
        }
    }
}

//====================================================
// CASE 7
// NON GUARDED
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

    if (n < 0) {

        for (int i = 0; i < n; i++) {
            B[i] = A[i] + x;
        }
    }
}

//-----------------------------------------------------
// CASO 8
//
// do-while seguito da un loop non guarded
//
// Il primo loop NON è guarded.
// Il secondo loop NON è guarded.
//
// Deve entrare nel caso:
//
//   L0 non guarded
//   L1 non guarded
//-----------------------------------------------------
void do_while_then_guarded(int *A, int *B, int n) {

    int i = 0;

    do {
        A[i] = B[i] + 1;
        i++;
    } while (i < n);

    if (n > 0) {

        for (int j = 0; j < n; j++) {
            B[j] = A[j] * 2;
        }
    }
}

//-----------------------------------------------------
// CASO 9
//
// do-while seguito da do-while
//
// Nessun loop guarded.
//
// Deve entrare nel caso:
//
//   L0 non guarded
//   L1 non guarded
//-----------------------------------------------------
void do_while_then_do_while(int *A, int *B, int n) {

    int i = 0;

    do {
        A[i] = B[i];
        i++;
    } while (i < n);

    int j = 0;

    do {
        B[j] = A[j] + 10;
        j++;
    } while (j < n);
}

//-----------------------------------------------------
// CASO 10
//
// do-while guarded
// seguito da do-while non guarded
//
// Deve entrare nel caso:
//
//   L0 guarded
//   L1 non guarded
//-----------------------------------------------------
void guarded_do_while_then_plain_do_while(
    int *A,
    int *B,
    int n) {

    if (n > 0) {

        int i = 0;

        do {
            A[i] = B[i] + 1;
            i++;
        } while (i < n);
    }

    int j = 0;

    do {
        B[j] = A[j] * 3;
        j++;
    } while (j < n);
}

//-----------------------------------------------------
// CASO 11
//
// due do-while non guarded
//
// Deve entrare nel caso:
//
//   L0 non guarded
//   L1 non guarded
//
//-----------------------------------------------------
void two_guarded_do_whiles_same_guard(
    int *A,
    int *B,
    int n) {

    if (n > 0) {

        int i = 0;

        do {
            A[i] = B[i];
            i++;
        } while (i < n);

        int j = 0;

        do {
            B[j] = A[j] + 5;
            j++;
        } while (j < n);
    }
}

//-----------------------------------------------------
// CASO 12
//
// due do-while con guardie diverse
//
// utile per testare haveSameGuard()
//-----------------------------------------------------
void two_guarded_do_whiles_different_guard(
    int *A,
    int *B,
    int n) {

    if (n > 0) {

        int i = 0;

        do {
            A[i] = B[i];
            i++;
        } while (i < n);
    }

    if (n > 1) {

        int j = 0;

        do {
            B[j] = A[j];
            j++;
        } while (j < n);
    }
}

//-----------------------------------------------------
// CASO 13
//
// due do-while con stessa guardia
//
// utile per testare haveSameGuard()
//-----------------------------------------------------
void two_guarded_do_whiles_same2_guard(
    int *A,
    int *B,
    int n) {

    if (n > 0) {

        int i = 0;

        do {
            A[i] = B[i];
            i++;
        } while (i < n);
    }

    if (n > 0) {

        int j = 0;

        do {
            B[j] = A[j];
            j++;
        } while (j < n);
    }
}




int main() {

    int A[N];
    int B[N];
    int C[N];

    adjacent_plain(A, B, C, N);

    dirty_preheader(A, B, C, N);

    guarded_same_guard(A, B, N);

    guarded_intermediate_block(A, B, N);

    do_while_then_guarded(A, B, N);

    do_while_then_do_while(A, B, N);

    guarded_do_while_then_plain_do_while(A, B, N);

    two_guarded_do_whiles_same_guard(A, B, N);

    two_guarded_do_whiles_different_guard(A, B, N);

    two_guarded_do_whiles_same2_guard(A, B, N);


    return 0;
}