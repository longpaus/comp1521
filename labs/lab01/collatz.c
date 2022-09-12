#include <stdio.h>
#include <stdlib.h>

int collatzRecur(int num);

int main(int argc, char **argv) {
	int num = atoi(argv[1]);
	collatzRecur(num);
	return EXIT_SUCCESS;
}

int collatzRecur(int num) {
	printf("%d\n", num);
	if (num == 1)
		return 1;
	return (num % 2 == 0) ? collatzRecur(num / 2) : collatzRecur(3 * num + 1);
}
