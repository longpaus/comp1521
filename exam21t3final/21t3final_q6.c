#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

// print a specified byte from a file
//
// first command line argument specifies a file
// second command line argument specifies a byte location
//
// output is a single line containing only the byte's value
// printed as a unsigned decimal integer (0..255)
// if the location does not exist in the file
// a single line is printed saying: error

int main(int argc, char *argv[]) {
	FILE *f = fopen(argv[1], "r");
	fseek(f, 0, SEEK_END);
	long size = ftell(f);
	int bytePos = atoi(argv[2]);
	if (bytePos > 0) {
		if (bytePos > size) {
			printf("error\n");
			return 0;
		}
		fseek(f, bytePos, SEEK_SET);
		int c = fgetc(f);
		printf("%d\n", c);
		return 0;
	}
	if (-1*bytePos > size) {
		printf("error\n");
		return 0;
	}
	fseek(f, bytePos, SEEK_END);
	int c = fgetc(f);
	printf("%d\n", c);
	return 0;
}
