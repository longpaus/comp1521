#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>


void getValForThreeRegis(uint32_t instruction,uint32_t *instrucComp){
    uint32_t mask = (1 << 11) - 1;
    instrucComp[4] = instruction & mask;
    instruction >>= 11;

    mask = (1 << 5) - 1;

    instrucComp[3] = instruction & mask;
    instruction >>= 5;
    instrucComp[2] = instruction & mask;
    instruction >>= 5;
    instrucComp[1] = instruction & mask;

    instruction >>= 5;
    mask = (1 << 6) - 1;
    instrucComp[0] = instruction & mask;
}   

int main(){
	/*
	instrucComp[0] : key1
	instrucComp[1] : s
	instrucComp[2] : t
	instrucComp[3] :d
	instrucComp[4] : key2
	*/
	uint32_t instrucComp[5];
	getValForThreeRegis(0x02302020,instrucComp);

	printf("d : %u ,  t : %d  ,  s : %d",instrucComp[3],instrucComp[1],instrucComp[2]);

}

