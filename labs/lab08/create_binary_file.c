#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    FILE *f = fopen(argv[1],"w");
    for(int i = 1; i < argc; i++){
        fputc(atoi(argv[i]),f);
    }
    fclose(f);

}