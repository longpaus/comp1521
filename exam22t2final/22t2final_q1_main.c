// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int count_zero_bits(uint32_t x);

#ifdef main
#undef main
#endif

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <number>\n", argv[0]);
		return EXIT_FAILURE;
	}

	uint32_t input = strtoul(argv[1], NULL, 10);

	int zero_bits = count_zero_bits(input);
	printf("%d\n", zero_bits);

	return EXIT_SUCCESS;
}
