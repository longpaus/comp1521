#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {
    for(int i = 0; i < n_rotations; i++){
        //get last bit in bits
        uint16_t firstBit = (bits >> 15);

        bits <<= 1;
        bits |= firstBit;
    }
    return bits; 
}
