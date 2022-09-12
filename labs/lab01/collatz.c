#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
	int num = atoi(argv[1]);
	while(num != 1){
		printf("%d\n",num);		
		if(num % 2 != 0)
			num = 3*num + 1;
		else
			num /= 2;
	}
	printf("1\n");	
	return EXIT_SUCCESS;
}
