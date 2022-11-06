#include <stdio.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void func(uint32_t *num){
	*num = 0;
}

int main(){
	int check = 0;
	for(uint32_t pc = 0; pc < 10; pc++){
		printf("%d\n",pc);
		if(1){
			continue;
		}
		printf("cdhchdb");
	}
}

