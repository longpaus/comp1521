#include <stdio.h>
#include <ctype.h>

int main(){
    int letter;
    while((letter = getchar())!= EOF){
        if(isupper(letter)){
            letter = tolower(letter);
        }
        putchar(letter);
    }

}
