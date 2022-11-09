#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void getValForThreeRegis(uint32_t instruction, uint32_t *instrucComp) {
	uint32_t mask = (1 << 11) - 1;
	instrucComp[4] = instruction & mask;
	instruction >>= 11;

	mask = (1 << 5) - 1;

	instrucComp[3] = instruction & mask;
	instruction >>= 5;
	instrucComp[2] = instruction & mask;
	instruction >>= 5;
	instrucComp[1] = instruction & mask;

	instruction >>= 5;
	mask = (1 << 6) - 1;
	instrucComp[0] = instruction & mask;
}

int main() {
    uint32_t num1 = 42424242;
    uint32_t num2 = 11223344;
    uint64_t prod = (num1*num2);

	uint64_t mask = ((uint32_t)1 << 31) - 1;
	uint32_t lo = (prod & mask);
	prod >>= 32;
	uint32_t hi =prod;
    printf("hi: %d, lo: %d",hi,lo);
}
