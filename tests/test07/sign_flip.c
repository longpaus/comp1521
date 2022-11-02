#include "sign_flip.h"

// given the 32 bits of a float return it with its sign flipped
uint32_t sign_flip(uint32_t f) {
    uint32_t newNum = ((f >> 31) == 1) ? 0 : 1;
    newNum <<= 31;
    uint32_t mask = (1 << 31) - 1;
    f = f & mask;
    return newNum | f;

}
