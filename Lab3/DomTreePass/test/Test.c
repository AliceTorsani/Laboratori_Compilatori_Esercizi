#include <stdio.h>

int test(int x) {
A:
    if (x < 0)
        goto B;
    else
        goto C;

B:
    x = x + 1;
    goto G;

C:
    if (x % 2 == 0)
        goto D;
    else
        goto E;

D:
    x = x * 2;
    goto F;

E:
    x = x - 1;
    goto F;

F:
    x = x + 10;
    goto G;

G:
    return x;
}

int main() {
    int res = test(5);
    printf("%d\n", res);
    return 0;
}