# read a number n and print the integers 1..n one per line

# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.

# YOUR-NAME-HERE, DD/MM/YYYY


# ![tabsize(8)]

main:                               # int main(void)
    la      $a0,    prompt          # printf("Enter a number: ");
    li      $v0,    4
    syscall 

    li      $v0,    5               # scanf("%d", number);
    syscall 

    move    $s0,    $v0             # s0 - number

    li      $t1,    1               # t1 - i
loop:
    bgt     $t1,    $s0,    end

    li      $v0,    1               # print_int
    move    $a0,    $t1             # print(i)
    syscall 

    li      $v0,    11              # print_char
    li      $a0,    '\n'            # printf("%c", '\n');
    syscall 

    addi    $t1,    $t1,    1       # add the counter by 1
    b       loop                    # branch to loop




end:
    li      $v0,    0
    jr      $ra                     # return 0

.data
prompt:
.asciiz "Enter a number: "
