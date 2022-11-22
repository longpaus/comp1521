#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc,char *argv[]){
    char *value = getenv("HOME");
    char path[100];
    strcpy(path,value);
    strcat(path,"/.diary");
    FILE *f = fopen(path,"a");
    for(int i = 1; i < argc; i++){
        fputs(argv[i],f);
        fprintf(f," ");
    }    
    fprintf(f,"\n");
    fclose(f);

}