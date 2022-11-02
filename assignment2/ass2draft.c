#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>


int main(){
	//if the first 6 bits from the left is 0 then instruction is add,sub,slt,mult,div
	printf("enter number:");
	uint32_t num;
	scanf("%d",&num);
	printf("%d\n",num);
	num >>= 11;
	uint32_t mask = (1 << 5) - 1;
	uint32_t d = num & mask;
	num >>= 5;
	uint32_t t = num & mask;
	num >>= 5;
	uint32_t s = num & mask;

	printf("d : %d ,  t : %d  ,  s : %d",d,t,s);
}