#include <stdio.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void func(uint32_t *num){
	*num = 0;
}
int16_t twosCompToDec(uint32_t two_compliment_val)
{
    // [0x0000; 0x7FFF] corresponds to [0; 32,767]
    // [0x8000; 0xFFFF] corresponds to [-32,768; -1]
    // int16_t has the range [-32,768; 32,767]

    uint32_t sign_mask = 0x8000;

    // if positive
    if ( (two_compliment_val & sign_mask) == 0 ) {
        return two_compliment_val;
    //  if negative
    } else {
        // invert all bits, add one, and make negative
        return -(~two_compliment_val + 1);
    }
}
int main(){
	uint32_t n = 65533;
	printf("%d\n",twosCompToDec(n));
	
}

