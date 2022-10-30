// Multiply a float by 2048 using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// float_2048 is given the bits of a float f as a uint32_t
// it uses bit operations and + to calculate f * 2048
// and returns the bits of this value as a uint32_t
//
// if the result is too large to be represented as a float +inf or -inf is returned
//
// if f is +0, -0, +inf or -inf, or Nan it is returned unchanged
//
// float_2048 assumes f is not a denormal number
//
uint32_t float_2048(uint32_t f) {
    float_components_t com = float_bits(f);
    if(is_nan(com) == 1){
        uint32_t nan = 0;
        nan |= 0xff;
        nan <<= 1;
        nan |= 1;
        nan <<= 22;
        return nan;
    }
    uint32_t mask = (1 << 23) - 1;
    uint32_t fraction = f & mask; // fraction contains first 23 bits of f
    f >>= 23;
    mask = (1 << 8) - 1;
    uint32_t newExp = (f & mask) + 11;
    f >>= 8;
    f <<= 8;
    f |= newExp;
    f <<= 23;
    f |= fraction;
    return f;
}
