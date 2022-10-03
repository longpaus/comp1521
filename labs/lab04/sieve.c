// Sieve of Eratosthenes
// https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define ARRAY_LEN 1000

uint8_t prime[ARRAY_LEN];

int main(void) {

    // Sets every element in the array to 1.
    // This has already been done for you
    // in the data segment of the provided MIPS code.
    memset(prime, 1, ARRAY_LEN);


    for (int i = 2; i < ARRAY_LEN; i++) {
        if (prime[i]) {
            printf("%d\n", i);
            for (int j = 2 * i; j < ARRAY_LEN; j += i) {
                prime[j] = 0;
            }
        }
    }

    return 0;
}
