// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 7

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <errno.h>

void _22t2final_q7(char *directory, char *name, int min_depth, int max_depth);

// Call the `22t2final_q7()' function from the command-line.
// See the exam paper and `22t2final_q7.c' file for a description of the question.
int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage %s <directory> [name] [min_depth] [max_depth]\n", argv[0]);
        return EXIT_FAILURE;
    }

	char *directory = argv[1];
	char *name = argc > 2 && strlen(argv[2]) ? argv[2] : NULL;
	int min_depth = -1;
	int max_depth = -1;

	if (argc > 3) {
		char *endptr;
		errno = 0;
		min_depth = strtoul(argv[3], &endptr, 0);
		if (errno != 0 || endptr == argv[3]) {
			fprintf(stderr, "Invalid min_depth: %s\n", argv[3]);
			return EXIT_FAILURE;
		}
	}

	if (argc > 4) {
		char *endptr;
		errno = 0;
		max_depth = strtoul(argv[4], &endptr, 0);
		if (errno != 0 || endptr == argv[4]) {
			fprintf(stderr, "Invalid max_depth: %s\n", argv[4]);
			return EXIT_FAILURE;
		}
	}

    _22t2final_q7(directory, name, min_depth, max_depth);

    return EXIT_SUCCESS;
}
