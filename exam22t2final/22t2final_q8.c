// // // // // // // // DO NOT CHANGE THIS FILE! // // // // // // // //
// COMP1521 22T2 ... final exam, question 8

#include <stdlib.h>

#include "final_q8.h"

char default_char = ' ';

void move_disks(char size, char *target, char *peg1, char *peg2) {
    char *peg_max = &default_char;
    char *source = NULL;
    char *other = NULL;

    for (int i = 0; peg1[i] != '\0'; i++) {
        if (peg1[i] > *peg_max && peg1[i] <= size) {
            peg_max = peg1 + i;
            source = peg1;
            other = peg2;
        }
        if (peg2[i] > *peg_max && peg2[i] <= size) {
            peg_max = peg2 + i;
            source = peg2;
            other = peg1;
        }
    }

    if (*peg_max == ' ') return;

    move_disks(size - 1, other, source, target);
    char *lowest_target = find_lowest_target(target);
    swap(peg_max, lowest_target);

    while (*peg_max != *(peg_max + 1)) {
        swap(peg_max, peg_max + 1);
        peg_max++;
    }

    print_towers();
    move_disks(size - 1, target, source, other);
}

char *find_lowest_target(char *target) {
    if (*target == ' ') return target;
    return find_lowest_target(target + 1);
}
