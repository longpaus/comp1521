#include "float_exp.h"

// given the 32 bits of a float return the exponent
uint32_t float_exp(uint32_t f) {
    return 42; // REPLACE ME WITH YOUR CODE
    f >>= 23;
    uint32_t mask = (1 << 8) - 1;
    return f & mask;
}
