#include <stdio.h>
#define QUOTE '"'
int main(int argc, char **argv) {
	printf("Program name: %s\n",argv[0]);
	if(argc - 1 != 0)
		printf("There are %d arguments:\n",argc-1);
	else{
		printf("There are no other arguments\n");
		return 0;
	}
	for(int i = 1;i < argc;i++){
		printf("	Argument %d is %c%s%c\n",i,QUOTE,argv[i],QUOTE);
	}
	return 0;
}
