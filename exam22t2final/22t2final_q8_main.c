// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 8

#include <stdio.h>

#include "22t2final_q8.h"

#define NUM_DISKS 7

char towers[][NUM_DISKS + 2] = {
    "gfedcba ",
    "        ",
    "        ",
};

int main(void) {
    print_towers();
	char max_sz = max_size();
    move_disks(max_sz, towers[1], towers[0], towers[2]);

    return 0;
}

char max_size(void) {
	char max = towers[0][0];

	for (int i = 1; i < 3; i++) {
		if (towers[i][0] > max) max = towers[i][0];
	}

	return max;
}

void print_towers(void) {
    printf("================\n");
    for (int i = 0; i < 3; i++) {
        printf("|");
        for (int j = 0; j < NUM_DISKS; j++) {
            char print_me = towers[i][j];
            printf("%c ", print_me ? print_me : ' ' );
        }
        printf("|\n");

    }
    printf("================\n");
}

void swap(char *a, char *b) {
    *a = *a ^ *b;
    *b = *b ^ *a;
    *a = *a ^ *b;
}
