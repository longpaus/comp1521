#include <stdio.h>
#include <string.h>

int main(void) {
	char str[1024];
	int linecount = 0;
	while(fgets(str,1024,stdin) != NULL){
		if(linecount % 2 == 0){
			fputs(str,stdout);
		}
		linecount++;
	}
	return 0;
}
