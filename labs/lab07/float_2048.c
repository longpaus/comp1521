// Multiply a float by 2048 using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

// #include "floats.h"

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
typedef struct float_components {
    uint32_t sign;
    uint32_t exponent;
    uint32_t fraction;
} float_components_t;
float_components_t float_bits(uint32_t f) {
    float_components_t components;
    uint32_t mask = (1 << 23) - 1;
    components.fraction = f & mask;
    f >>= 23;
    mask = (1 << 8) - 1;
    components.exponent = f & mask;
    f >>= 8;
    components.sign = f | 0;
    return components;
}

// given the 3 components of a float
// return 1 if it is NaN, 0 otherwise
int is_nan(float_components_t f) {
    return (f.fraction >> 22 && f.exponent == 0xff) ? 1 : 0;
}

// given the 3 components of a float
// return 1 if it is inf, 0 otherwise
int is_positive_infinity(float_components_t f) {
    if(is_nan(f)){
        return 0;
    }
    return (f.exponent == 0xff && f.sign == 0) ? 1 : 0;
}

// given the 3 components of a float
// return 1 if it is -inf, 0 otherwise
int is_negative_infinity(float_components_t f) {
    if(is_nan(f)){
        return 0;
    }
    return (f.exponent == 0xff && f.sign == 1) ? 1 : 0;
}

// given the 3 components of a float
// return 1 if it is 0 or -0, 0 otherwise
int is_zero(float_components_t f) {
    return (f.fraction == 0 && f.exponent == 0) ? 1 : 0;
}

uint32_t float_2048(uint32_t f) {
    float_components_t com = float_bits(f);
    if(is_nan(com) == 1){
        return(((0 | 0xff) << 1) | 1) << 22;
    }
    if(is_zero(com) == 1){
        return (com.sign == 1) ? (uint32_t)1 << 31 : 0;
    }
    uint32_t mask = (1 << 23) - 1;
    uint32_t fraction = f & mask; // fraction contains first 23 bits of f
    f >>= 23;
    mask = (1 << 8) - 1;
    uint32_t newExp = (f & mask) + 11;
    if(newExp > 255){
        if(com.sign == 1){
            return ((1 << 8) | 0xff) << 23;
        }
        return ((0 << 8) | 0xff) << 23;
    }
    f >>= 8;
    f <<= 8;
    f |= newExp;
    f <<= 23;
    f |= fraction;
    return f;
}
