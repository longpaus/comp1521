// COMP1521 22T3 Assignment 2: mipsc -- a MIPS simulator
// starting point code v1.0 - 24/10/22


// PUT YOUR HEADER COMMENT HERE


#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>

// ADD ANY ADDITIONAL #include HERE

#define MAX_LINE_LENGTH 256
#define INSTRUCTIONS_GROW 64

// ADD ANY ADDITIONAL #defines HERE

void execute_instructions(uint32_t n_instructions,
                          uint32_t instructions[],
                          int trace_mode);
char *process_arguments(int argc, char *argv[], int *trace_mode);
uint32_t *read_instructions(char *filename, uint32_t *n_instructions_p);
uint32_t *instructions_realloc(uint32_t *instructions, uint32_t n_instructions);

// ADD ANY ADDITIONAL FUNCTION PROTOTYPES HERE

// YOU DO NOT NEED TO CHANGE MAIN
// but you can if you really want to
int main(int argc, char *argv[]) {
    int trace_mode;
    char *filename = process_arguments(argc, argv, &trace_mode);

    uint32_t n_instructions;
    uint32_t *instructions = read_instructions(filename, &n_instructions);

    execute_instructions(n_instructions, instructions, trace_mode);

    free(instructions);
    return 0;
}


// simulate execution of  instruction codes in  instructions array
// output from syscall instruction & any error messages are printed
//
// if trace_mode != 0:
//     information is printed about each instruction as it executed
//
// execution stops if it reaches the end of the array
void execute_instructions(uint32_t n_instructions,
                          uint32_t instructions[],
                          int trace_mode) {

    // REPLACE THIS FUNCTION WITH YOUR OWN IMPLEMENTATION

    for (uint32_t pc = 0; pc < n_instructions; pc++) {
        if (trace_mode) {
            printf("%u: 0x%08X\n", pc, instructions[pc]);
        }
    }
}



// ADD YOUR FUNCTIONS HERE



// DO NOT CHANGE ANY CODE BELOW HERE


// check_arguments is given command-line arguments
// it sets *trace_mode to 0 if -r is specified
//         *trace_mode is set to 1 otherwise
// the filename specified in command-line arguments is returned
char *process_arguments(int argc, char *argv[], int *trace_mode) {
    if (
        argc < 2 ||
        argc > 3 ||
        (argc == 2 && strcmp(argv[1], "-r") == 0) ||
        (argc == 3 && strcmp(argv[1], "-r") != 0)
    ) {
        fprintf(stderr, "Usage: %s [-r] <file>\n", argv[0]);
        exit(1);
    }
    *trace_mode = (argc == 2);
    return argv[argc - 1];
}


// read hexadecimal numbers from filename one per line
// numbers are return in a malloc'ed array
// *n_instructions is set to size of the array
uint32_t *read_instructions(char *filename, uint32_t *n_instructions_p) {
    FILE *f = fopen(filename, "r");
    if (f == NULL) {
        perror(filename);
        exit(1);
    }

    uint32_t *instructions = NULL;
    uint32_t n_instructions = 0;
    char line[MAX_LINE_LENGTH + 1];
    while (fgets(line, sizeof line, f) != NULL) {

        // grow instructions array in steps of INSTRUCTIONS_GROW elements
        if (n_instructions % INSTRUCTIONS_GROW == 0) {
            instructions = instructions_realloc(instructions, n_instructions + INSTRUCTIONS_GROW);
        }

        char *endptr;
        instructions[n_instructions] = (uint32_t)strtoul(line, &endptr, 16);
        if (*endptr != '\n' && *endptr != '\r' && *endptr != '\0') {
            fprintf(stderr, "line %d: invalid hexadecimal number: %s",
                    n_instructions + 1, line);
            exit(1);
        }
        if (instructions[n_instructions] != strtoul(line, &endptr, 16)) {
            fprintf(stderr, "line %d: number too large: %s",
                    n_instructions + 1, line);
            exit(1);
        }
        n_instructions++;
    }
    fclose(f);
    *n_instructions_p = n_instructions;
    // shrink instructions array to correct size
    instructions = instructions_realloc(instructions, n_instructions);
    return instructions;
}


// instructions_realloc is wrapper for realloc
// it calls realloc to grow/shrink the instructions array
// to the specified size
// it exits if realloc fails
// otherwise it returns the new instructions array
uint32_t *instructions_realloc(uint32_t *instructions, uint32_t n_instructions) {
    instructions = realloc(instructions, n_instructions * sizeof *instructions);
    if (instructions == NULL) {
        fprintf(stderr, "out of memory");
        exit(1);
    }
    return instructions;
}
