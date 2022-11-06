#include <stdio.h>

int main(int argc, char *argv[]){
    FILE *f = fopen(argv[1],"r");
    int c;
    int counter = 0;
    while((c = fgetc(f)) != EOF){
        
        if((c > 188 && c < 196) || c == '\t' || (c > 127 && c < 130) || (c >= 0 && c <= '\n')){
            printf("byte %4d: %3d 0x%02x\n",counter,c,c);
        }
        else{
            printf("byte %4d: %3d 0x%02x '%c'\n",counter,c,c,c);
        }
        counter++;
    }
    fclose(f);
}