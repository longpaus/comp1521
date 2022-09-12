#include <stdio.h>
#include <string.h>

int isLetterAVowel(char letter);


int main(void) {
	char letter;
	while(scanf("%c",&letter) != EOF){
		if(isLetterAVowel(letter) == 1){
			printf("%c",letter);
		}
	}
	return 0;
}

int isLetterAVowel(char letter){
	char vowels[10] = {'a','e','i','o','u','A','E','I','O','U'};
	for(int i = 0;i< 10;i++){
		if(vowels[i] == letter){
			return 0;
		}
	}
	return 1;
}
