#include <stdio.h>

// read two integers and print all the integers which have their bottom 2 bits set.

int main(void) {
    int x, y;

    scanf("%d", &x);
    scanf("%d", &y);
    int mask = 3;
    for(int i = x + 1; i < y; i++){
        if((mask & i) == 3) printf("%d\n",i);
    }

    return 0;
}
