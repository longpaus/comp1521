#include <stdio.h>

int main(int argc, char *argv[]){
    FILE *f = fopen(argv[1],"r");
    int c;
    int counter = 0;
    while((c = fgetc(f)) != EOF){
        if(c != '\n')
           printf("byte    %d:  %d 0x%02x '%c'\n",counter,c,c,c);
    }
}