// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 1

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint32_t _22t2final_q3(uint32_t value);

#ifdef main
#undef main
#endif

// Calls the `22t2final_q3()' function from the command-line.
// See the exam paper and `22t2final_q3.c' file for a description of the question.
int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Usage %s <value>\n", argv[0]);
        return EXIT_FAILURE;
    }

    uint32_t value = strtol(argv[1], NULL, 0);
    printf("22t2final_q3(0x%08X) returned 0x%08X\n", value, _22t2final_q3(value));

    return EXIT_SUCCESS;
}
