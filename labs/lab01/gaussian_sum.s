
# COMP1521 lab exercise sample solution

# A simple MIPS program that calculates the Gaussian sum between two numbers
# Written 12/2/2022
# by Dylan Brotherston (d.brotherston@unsw.edu.au)

# int main(void)
# {
# int number1, number2;

# printf("Enter first number: ");
# scanf("%d", &number1);

# printf("Enter second number: ");
# scanf("%d", &number2);

# int gaussian_sum = ((number2 - number1 + 1) * (number1 + number2)) / 2;

# printf("The sum of all numbers between %d and %d (inclusive) is: %d\n", number1, number2, gaussian_sum);

# return 0;
# }

main:

    la      $a0,    prompt1
    li      $v0,    4
    syscall 
    li      $v0,    5                   # scanf
    syscall 

    move    $t0,    $v0                 # t0 = number1

    la      $a0,    prompt2
    li      $v0,    4
    syscall 
    li      $v0,    5                   # scanf
    syscall 

    move    $t1,    $v0                 # t1 = number2

    sub     $t2,    $t1,        $t0     # t2 = number2 - number1
    addi    $t2,    $t2,        1       # t2 = number2 - number1 + 1

    addu    $t3,    $t0,        $t1     # t3 = number1 + number2
    divu    $t3,    $t3,        2       # t3 = (number1 + number2)/2

    mul     $t4,    $t3,        $t2     # t4 = (number2 - number1 + 1)*(number1 + number2)/2

    la      $a0,    answer1
    li      $v0,    4
    syscall 

    move    $a0,    $t0
    li      $v0,    1
    syscall 

    la      $a0,    answer2
    li      $v0,    4
    syscall 

    move    $a0,    $t1
    li      $v0,    1
    syscall 

    la      $a0,    answer3
    li      $v0,    4
    syscall 

    move    $a0,    $t4
    li      $v0,    1
    syscall 

    li      $a0,    '\n'                # printf("%c", '\n');
    li      $v0,    11
    syscall 






    li      $v0,    0
    jr      $ra                         # return


.data
prompt1: .asciiz "Enter first number: "
prompt2: .asciiz "Enter second number: "

answer1: .asciiz "The sum of all numbers between "
answer2: .asciiz " and "
answer3: .asciiz " (inclusive) is: "
