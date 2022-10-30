// Extract the 3 parts of a float using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// separate out the 3 components of a float
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
    // PUT YOUR CODE HERE

    if(f.fraction == 0 && f.exponent == 0){
        return 1;
    }
    return 0;
}
