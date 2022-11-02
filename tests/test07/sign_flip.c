#include "sign_flip.h"

// given the 32 bits of a float return it with its sign flipped
uint32_t sign_flip(uint32_t f) {
    uint32_t newSign = ((f >> 31) == 1) ? 0 : 1;
    newSign <<= 31;
    uint32_t mask = ((uint32_t)1 << 31) - 1;
    f = f & mask;
    return newSign | f;

}
