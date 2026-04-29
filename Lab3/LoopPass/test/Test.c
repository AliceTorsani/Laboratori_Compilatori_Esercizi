#include <stdio.h>

int main() {
    int i, j, k;

    // ========================
    // 1. Loop semplice
    // ========================
    for (i = 0; i < 5; i++) {
        printf("Loop semplice: %d\n", i);
    }

    // ========================
    // 2. Due loop in sequenza
    // ========================
    for (i = 0; i < 3; i++) {
        printf("Primo loop sequenziale: %d\n", i);
    }

    for (j = 0; j < 3; j++) {
        printf("Secondo loop sequenziale: %d\n", j);
    }

    // ========================
    // 3. Loop annidati (2 livelli)
    // ========================
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 2; j++) {
            printf("Loop annidato 2 livelli: %d %d\n", i, j);
        }
    }

    // ========================
    // 4. Loop annidati (3 livelli)
    // ========================
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 2; j++) {
            for (k = 0; k < 2; k++) {
                printf("Loop annidato 3 livelli: %d %d %d\n", i, j, k);
            }
        }
    }

    // ========================
    // 5. While loop
    // ========================
    i = 0;
    while (i < 3) {
        printf("While loop: %d\n", i);
        i++;
    }

    // ========================
    // 6. Loop con break
    // ========================
    for (i = 0; i < 10; i++) {
        if (i == 4) {
            break;
        }
        printf("Loop con break: %d\n", i);
    }

    // ========================
    // 7. Loop con continue
    // ========================
    for (i = 0; i < 5; i++) {
        if (i % 2 == 0) {
            continue;
        }
        printf("Loop con continue: %d\n", i);
    }

    return 0;
}