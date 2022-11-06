#include<stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) { 
    char mode[10] = "w";
    FILE *f = fopen(argv[1],mode);
    int start = atoi(argv[2]);
    int end = atoi(argv[3]);
    for(int i = start; i <= end; i++){
        fprintf(f, "%d\n", i);
    }
    fclose(f);
}
