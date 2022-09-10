// #include<stdio.h>
// int main(){
//     int number = 3;
//     printf("%p\n",&number);
//     int *num = &number;
//     printf("%d",*num);
//     return 0;
// }

#include <stdio.h>

void print_array(int *nums, int len) {
    for (int i = 0; i < len; i++) {
        printf("%d\n", nums[i]);
    }
}

int main(void)
{
    int nums[] = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
    print_array(nums, 10);

    return 0;
}