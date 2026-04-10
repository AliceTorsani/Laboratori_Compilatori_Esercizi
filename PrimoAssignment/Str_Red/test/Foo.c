#include <stdio.h>

// ==========================
// TEST MOLTIPLICAZIONI
// ==========================
int test_mul(int x) {
    int a = x * 8;    // 2^3 → shift
    int b = x * 16;   // 2^4 → shift

    int c = x * 15;   // 2^4 - 1 → (x << 4) - x
    int d = x * 9;    // 2^3 + 1 → (x << 3) + x

    int e = 8 * x;    // costante a sinistra
    int f = 15 * x;   // costante a sinistra (2^n - 1)

    return a + b + c + d + e + f;
}

// ==========================
// TEST DIVISIONI (SIGNED)
// ==========================
int test_div_signed(int x) {
    int a = x / 8;    // 2^3 → shift
    int b = x / 16;   // 2^4 → shift

    int c = x / 15;   // 2^4 - 1 → approx
    int d = x / 9;    // 2^3 + 1 → approx

    return a + b + c + d;
}

// ==========================
// TEST DIVISIONI (UNSIGNED)
// ==========================
unsigned int test_div_unsigned(unsigned int x) {
    unsigned int a = x / 8;    // shift logico
    unsigned int b = x / 16;

    unsigned int c = x / 15;   // approx
    unsigned int d = x / 9;    // approx

    return a + b + c + d;
}

// ==========================
// TEST COMBINATO (ANNIDATO)
// ==========================
int test_mix(int x) {
    int a = (x * 8) / 8;       // dovrebbe semplificarsi completamente
    int b = (x * 15) / 15;     // interessante per vedere combinazioni
    int c = (x * 9) / 9;

    int d = (x * 8) / 4;       // (x << 3) >> 2 → x << 1

    return a + b + c + d;
}
