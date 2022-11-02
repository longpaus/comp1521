#include "sign_flip.h"

// given the 32 bits of a float return it with its sign flipped
uint32_t sign_flip(uint32_t f) {
    uint32_t newNum = ((f >> 30) == 1) ? 0 : 1;
    newNum <<= 30;
    uint32_t mask = (1 << 30) - 1;
    f = f & mask;
    return newNum | f;

}
