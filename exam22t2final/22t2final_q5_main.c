// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void print_bytes(FILE *file, long bytes);

#ifdef main
#undef main
#endif

int main(int argc, char *argv[]) {
	if (argc != 3) {
		fprintf(stderr, "Usage: %s <file> <bytes>\n", argv[0]);
		return EXIT_FAILURE;
	}

	FILE *file = fopen(argv[1], "r");
	if (!file) {
		perror(argv[1]);
		return EXIT_FAILURE;
	}

	char *endptr;
	errno = 0;
	long bytes = strtol(argv[2], &endptr, 0);
	if (errno != 0 || endptr == argv[2]) {
		fprintf(stderr, "Invalid number: %s\n", argv[2]);
		return EXIT_FAILURE;
	}

	print_bytes(file, bytes);

	return EXIT_SUCCESS;
}
