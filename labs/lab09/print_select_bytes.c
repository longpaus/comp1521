#include <stdio.h>
#include <stdlib.h>

int main(int argc,char *argv[]){
    FILE *f = fopen(argv[1],"r");
    int c;
    for(int i = 2; i < argc; i++){
        fseek(f,atoi(argv[i]),SEEK_SET);
        c = fgetc(f);
        printf("%d - 0x%02X - '%c'\n",c,c,c);
    }
    fclose(f);
}