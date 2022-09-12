#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	int num = atoi(argv[1]);
	while(num != 1){
		if(num % 2 != 0)
			num = 3*num + 1;
		else
			num /= 2;
		if(num != 1)
			printf("%d\n",num);	
	}
	printf("1\n");	
	return EXIT_SUCCESS;
}
