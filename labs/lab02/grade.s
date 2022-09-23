# read a mark and print the corresponding UNSW grade

# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.

# YOUR-NAME-HERE, DD/MM/YYYY

# ![tabsize(8)]

main:
    la      $a0,    prompt          # printf("Enter a mark: ");
    li      $v0,    4
    syscall 

    li      $v0,    5               # scanf("%d", mark);
    syscall 
    blt     $v0,    50,     fail    # if input < 50 goto fail
    blt     $v0,    65,     pass    # if input < 65 goto pass
    blt     $v0,    75,     credit
    blt     $v0,    85,     dist
    la      $a0,    hd
    li      $v0,    4
    syscall 
    li      $v0,    0
    jr      $ra

fail:
    la      $a0,    fl
    li      $v0,    4
    syscall 
    li      $v0,    0
    jr      $ra

pass:
    la      $a0,    ps
    li      $v0,    4
    syscall 
    li      $v0,    0
    jr      $ra
credit:
    la      $a0,    cr
    li      $v0,    4
    syscall 
    li      $v0,    0
    jr      $ra
dist:
    la      $a0,    dn
    li      $v0,    4
    syscall 
    li      $v0,    0
    jr      $ra

.data
prompt:
.asciiz "Enter a mark: "
fl:
.asciiz "FL\n"
ps:
.asciiz "PS\n"
cr:
.asciiz "CR\n"
dn:
.asciiz "DN\n"
hd:
.asciiz "HD\n"
