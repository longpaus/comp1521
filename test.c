#include <stdio.h>

void func(int *num){
	*num = 2;
}

int main(){
	int num = 5;
	func(&num);
	printf("%d\n",num);
}

