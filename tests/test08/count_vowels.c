#include <stdio.h>
#include <stdbool.h>
bool isLetterAVowel(char letter){
	char vowels[10] = {'a','e','i','o','u','A','E','I','O','U'};
	for(int i = 0;i< 10;i++){
		if(vowels[i] == letter){
			return true;
		}
	}
	return false;
}
int main(int argc,char *argv[]){
    FILE *f = fopen(argv[1],"r");
    int c;
    int count = 0;
    while((c = fgetc(f)) != EOF){
        if(isLetterAVowel(c)){
            count++;
        }
    }
    fclose(f);
    printf("%d\n",count);
    return 0;
}