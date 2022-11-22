// Reads 10 numbers into an array
// Prints the length of the longest sequence
// of strictly increasing numbers in the array.

#include <stdio.h>

int main(void) {
	int i;
	int numbers[10] = { 0 };

	i = 0;
	while (i < 10) {
		scanf("%d", &numbers[i]);
		i++;
	}

	int max_run = 1;
	int current_run = 1;
	i = 1;
	while (i < 10) {
		if (numbers[i] > numbers[i - 1]) {
			current_run++;
		} else {
			current_run = 1;
		}

		if (current_run > max_run) {
			max_run = current_run;
		}

		i++;
	}

	printf("%d\n", max_run);

	return 0;
}
