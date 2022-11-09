#include <stdio.h>

int main(int arc,char *argv[]){
    FILE *f1 = fopen(argv[1],"r");
    FILE *f2 = fopen(argv[2],"r");
    int c1,c2;
    int byte = 0;
    while(1){
        c1 = fgetc(f1);
        c2 = fgetc(f2);
        if(c1 == EOF && c2 == EOF){
            printf("Files are identical\n");
            break;
        }
        if(c1 == EOF){
            printf("EOF on %s\n",argv[1]);
            break;
        }
        if(c2 == EOF){
            printf("EOF on %s\n",argv[2]);
            break;
        }
        if(c1 != c2){
            printf("Files differ at byte %d\n",byte);
            break;
        }
        byte++;
    }
    fclose(f1);
    fclose(f2);
    return 0;
}