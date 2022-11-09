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
    FILE *f1 = fopen(argv[1],"r");
    FILE *f2 = fopen(argv[2],"w");
    int c;
    while((c = fgetc(f1)) != EOF){
        if(!isLetterAVowel(c)){
            fputc(c,f2);
        }
    }
    fclose(f1);
    fclose(f2);
    return 0;
}