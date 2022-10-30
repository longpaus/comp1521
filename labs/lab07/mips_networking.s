# Reads a 4-byte value and reverses the byte order, then prints it

########################################################################
# .TEXT <main>
main:
	# Locals:
	#	- $t0: int network_bytes
	#	- $t1: int computer_bytes
	#	- Add your registers here!


	li	$v0, 5		# scanf("%d", &x);
	syscall

	#
	# Your code here!
	#

	move	$a0, $v0	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
