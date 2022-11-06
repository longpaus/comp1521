#include <stdio.h>

int main(int argc, char *argv[]){
    FILE *f = fopen(argv[1],"r");
    fseek(f,-1,SEEK_END);
    long int size = ftell(f);

    long endOffset = (fgetc(f) == '\n') ? -2 : -1;

    long startOffset = endOffset;
    int c;
    while((c =fgetc(f)) != '\n' && startOffset*-1 < size){
        startOffset--;
        fseek(f,startOffset,SEEK_END);
    }
    fseek(f,startOffset + 1,SEEK_END);
    while((c = fgetc(f)) != '\n'){
        printf("%c",c);
    }
    fclose(f);


}
