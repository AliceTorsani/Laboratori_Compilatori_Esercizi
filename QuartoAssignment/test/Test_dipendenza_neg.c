#include <stdio.h>

#define N 100

//=========================================================
// CASO 1
// Nessuna dipendenza tra i due loop
//
// RISULTATO ATTESO:
// Nessuna dipendenza
// Fusione permessa
//=========================================================

void no_dependence(int *A, int *B, int *C) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N; i++) {
        B[i] = C[i];
    }
}

//=========================================================
// CASO 2
// Dipendenza distanza 0
//
// A[i] scritto da L0
// A[i] letto da L1
//
// RISULTATO ATTESO:
// Dipendenza presente
// Distanza = 0
// Fusione permessa
//=========================================================

void distance_zero(int *A, int *B) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }
}

//=========================================================
// CASO 3
// Dipendenza positiva
//
// L0 scrive A[i]
// L1 legge A[i-1]
//
// distanza = +1
//
// RISULTATO ATTESO:
// Dipendenza positiva
// Fusione permessa
//=========================================================

void positive_distance_1(int *A, int *B) {

    for (int i = 1; i < N; i++) {
        A[i] = i;
    }

    for (int i = 1; i < N; i++) {
        B[i] = A[i - 1];
    }
}

//=========================================================
// CASO 4
// Dipendenza positiva
//
// distanza = +3
//
// RISULTATO ATTESO:
// Fusione permessa
//=========================================================

void positive_distance_3(int *A, int *B) {

    for (int i = 3; i < N; i++) {
        A[i] = i;
    }

    for (int i = 3; i < N; i++) {
        B[i] = A[i - 3];
    }
}

//=========================================================
// CASO 5
// DIPENDENZA NEGATIVA
//
// Esempio classico
//
// L0:
//   A[i]
//
// L1:
//   A[i+1]
//
// distanza = -1
//
// RISULTATO ATTESO:
// Fusione NON permessa
//=========================================================

void negative_distance_minus1(int *A, int *B) {

    for (int i = 0; i < N - 1; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N - 1; i++) {
        B[i] = A[i + 1];
    }
}

//=========================================================
// CASO 6
// DIPENDENZA NEGATIVA
//
// distanza = -3
//
// RISULTATO ATTESO:
// Fusione NON permessa
//=========================================================

void negative_distance_minus3(int *A, int *B) {

    for (int i = 0; i < N - 3; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N - 3; i++) {
        B[i] = A[i + 3];
    }
}

//=========================================================
// CASO 7
// ESATTAMENTE IL CASO CHE HAI CHIESTO
//
// L0:
//   A[i] = ...
//
// L1:
//   B[i] = A[i+3]
//
// distanza = -3
//
// RISULTATO ATTESO:
// NEGATIVE DEPENDENCE
// Fusione IMPOSSIBILE
//=========================================================

void user_example(int *A, int *B) {

    for (int i = 0; i < N - 3; i++) {
        A[i] = i * 2;
    }

    for (int i = 0; i < N - 3; i++) {
        B[i] = A[i + 3] + 1;
    }
}

//=========================================================
// CASO 8
// Output dependence
//
// Entrambi scrivono A[i]
//
// RISULTATO ATTESO:
// Dependence presente
// distanza = 0
//
// Non negativa
//=========================================================

void output_dependence(int *A) {

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }

    for (int i = 0; i < N; i++) {
        A[i] = 2 * i;
    }
}

//=========================================================
// CASO 9
// Anti dependence
//
// L0 legge
// L1 scrive
//
// RISULTATO ATTESO:
// Dependence presente
// distanza = 0
//=========================================================

void anti_dependence(int *A, int *B) {

    for (int i = 0; i < N; i++) {
        B[i] = A[i];
    }

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }
}

int main() {

    int A[N];
    int B[N];
    int C[N];

    no_dependence(A, B, C);

    distance_zero(A, B);

    positive_distance_1(A, B);

    positive_distance_3(A, B);

    negative_distance_minus1(A, B);

    negative_distance_minus3(A, B);

    user_example(A, B);

    output_dependence(A);

    anti_dependence(A, B);

    return 0;
}