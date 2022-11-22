# COMP1521 22T2 ... final exam, question 2

main:
	li	$v0, 5		# syscall 5: read_int
	syscall
	move	$t0, $v0	# read integer into $t0


	# THESE LINES JUST PRINT 42\n
	# REPLACE THE LINES BELOW WITH YOUR CODE
	li	$v0, 1		# syscall 1: print_int
	li	$a0, 42
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");
	# REPLACE THE LINES ABOVE WITH YOUR CODE

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
