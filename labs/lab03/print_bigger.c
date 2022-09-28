// Read 10 numbers into an array then print the numbers which are
// larger than the final number read.

#include <stdio.h>

#define ARRAY_LEN 10

int main(void) {
    int i, final_number;
    int numbers[ARRAY_LEN] = { 0 };

    i = 0;
    while (i < ARRAY_LEN) {
        scanf("%d", &numbers[i]);
        final_number = numbers[i];
        i++;
    }
    i = 0;
    while (i < ARRAY_LEN) {
        if (numbers[i] >= final_number) {
            printf("%d\n", numbers[i]);
        }
        i++;
    }
}
