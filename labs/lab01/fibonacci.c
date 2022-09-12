#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30
int fibonacciRecur(int num1,int num2,int count);

int main(void) {
    int num;
    while(scanf("%d",&num) != EOF){
        printf("%d\n",fibonacciRecur(0,1,num));
    }
    return EXIT_SUCCESS;
}

int fibonacciRecur(int num1,int num2,int count){
    if(count == 0)
        return num1;
    return fibonacciRecur(num2,num1+num2,count - 1);
}
