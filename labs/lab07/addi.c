// generate the encoded binary for an addi instruction, including opcode and operands

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "addi.h"

// return the encoded binary MIPS for addi $t,$s, i
uint32_t addi(int t, int s, int i) {
    uint32_t fiveBitMask = (1 << 5) - 1; 
    s = s & fiveBitMask; // get the first 5 bits of s
    t = t & fiveBitMask; // get the first 5 bits of t

    uint32_t sixteenBitmask = (1 << 16) - 1;
    i = i & sixteenBitmask; // get the first 16 bits of i

    uint32_t ans = 8; // 001000
    ans = ans << 5;
    ans = ans | s; // place s into ans
    ans = ans << 5;
    ans = ans | t; // place t into ans
    ans = ans << 16;
    ans = ans | i;


    return ans; 

}
