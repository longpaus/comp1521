// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>

void print_bytes(FILE *file, long n) {
	long max = n - 1;
	if(n < 0){
		fseek(file,0,SEEK_END);
		max = ftell(file) + n - 1;
	}
	int c;
	int count = 0;
	fseek(file,0,SEEK_SET);
	while((c = fgetc(file)) != EOF){
		if(count > max){
			break;
		}
		printf("%c",c);
		count++;
	}
	fclose(file);
}
