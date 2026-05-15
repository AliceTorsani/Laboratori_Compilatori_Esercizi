#include <stdio.h>

int main() {

    int a = 10;
    int b = 20;

    int x = 0;
    int y = 0;

    for (int i = 0; i < 100; i++) {

        x = a + b;
        y = x * 2;
    }

    printf("%d %d\n", x, y);

    return 0;
}