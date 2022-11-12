#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    uint64_t num1 = 42424242;
    uint64_t num2 = 11223344;
    uint64_t prod = (num1*num2);
	printf("prod:%llu\n",prod);
	uint64_t mask = ((uint32_t)1 << 31) - 1;
	uint32_t lo = (prod & mask);
	prod >>= 32;
	uint32_t hi =prod;
    printf("hi: %d, lo: %d",hi,lo);
}
110860
110860