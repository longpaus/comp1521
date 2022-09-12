#include <stdio.h>
#include <string.h>

int main(void) {
	char str[1024];
	while (fgets(str, 1024, stdin) != NULL) {
		if (strlen(str) % 2 == 0)
			fputs(str, stdout);
	}
	return 0;
}
