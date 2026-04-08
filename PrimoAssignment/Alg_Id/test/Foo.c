#include <stdio.h>

int test(int x) {
    int a = x + 0;
    int b = 0 + x;
    int c = x * 1;
    int d = 1 * x;

    int e = (x + 0) * 1;
    int f = (1 * x) + 0;

    return a + b + c + d + e + f;
}
