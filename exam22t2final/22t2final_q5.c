// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>

void print_bytes(FILE *file, long n) {
	int max = (n >= 0) ? n : -n - 1;
	int c;
	int count = 0;
	while((c = fgetc(file)) != EOF){
		if(count > max){
			break;
		}
		printf("%c",c);
		count++;
	}
	fclose(file);
}
