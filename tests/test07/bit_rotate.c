#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {
    if(n_rotations > 0){
        for(int i = 0; i < n_rotations; i++){
        //get first bit in bits
        uint16_t firstBit = (bits >> 15);

        bits <<= 1;
        bits |= firstBit;
    }
    }else{
        for(int i = n_rotations * -1; i > 0; i--){
            uint16_t lastBit = (bits & 1);

            bits >>= 1;
            bits |= lastBit;
        }
    }
    
    return bits; 
}
