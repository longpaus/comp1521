// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 6

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <errno.h>

char *_22t2final_q6(char *string, unsigned int range_start, unsigned int range_end);

// Call the `22t2final_q6()' function from the command-line.
// See the exam paper and `22t2final_q6.c' file for a description of the question.
int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage %s <string> <range_start> <range_end>\n", argv[0]);
        return EXIT_FAILURE;
    }

	char *endptr;
	errno = 0;
	unsigned int range_start = strtoul(argv[2], &endptr, 0);
	if (errno != 0 || endptr == argv[2]) {
		fprintf(stderr, "Invalid range start: %s\n", argv[2]);
		return EXIT_FAILURE;
	}

	unsigned int range_end = strtoul(argv[3], &endptr, 0);
	if (errno != 0 || endptr == argv[3]) {
		fprintf(stderr, "Invalid range end: %s\n", argv[3]);
		return EXIT_FAILURE;
	}

    char *string = _22t2final_q6(argv[1], range_start, range_end);
    printf("22t2final_q6(\"%s\", %u, %u) returned \"%s\"\n", argv[1], range_start, range_end, string);

    assert(string != argv[1]); // Make sure the function did not modify the input string.

    free(string);

    return EXIT_SUCCESS;
}
