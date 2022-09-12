#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
	int min = atoi(argv[1]),max = atoi(argv[1]);
	int sum = 0, prod = 1;

	for(int i = 1; i < argc; i++){
		if(atoi(argv[i]) < min){
			min = atoi(argv[i]);
		}
		else if (atoi(argv[i]) > max){
			max = atoi(argv[i]);
		}
		sum += atoi(argv[i]);
		prod *= atoi(argv[i]);
	}
	printf("MIN:  %d\n",min);
	printf("MAX:  %d\n",max);
	printf("SUM:  %d\n",sum);
	printf("PROD: %d\n",prod);
	printf("MEAN: %d\n",sum/(argc-1));
}
