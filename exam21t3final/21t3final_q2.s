# read two integers and print all the integers which have their bottom 2 bits set.

main:
    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

loop:
	
    # THESE LINES JUST PRINT 42
    # REPLACE THE LINES BELOW WITH YOUR CODE
    li $a0, 42
    li $v0, 1
    syscall
    li   $a0, '\n'
    li   $v0, 11
    syscall
    # REPLACE THE LINES ABOVE WITH YOUR CODE


end:
    li $v0, 0
    jr $31
