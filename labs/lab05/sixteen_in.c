// Convert string of binary digits to 16-bit signed integer

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#define N_BITS 16

int16_t sixteen_in(char *bits);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        printf("%d\n", sixteen_in(argv[arg]));
    }

    return 0;
}

//
// given a string of binary digits ('1' and '0')
// return the corresponding signed 16 bit integer
//
int16_t sixteen_in(char *bits) {
    int16_t n = 0;
    for(int i = 0; i < N_BITS ;i++){
        int bitValue = (bits[i] == '1') ? 1 : 0;
        n |= bitValue;
        if(i != N_BITS -1)
            n <<= 1;
    }
    return n;
}

