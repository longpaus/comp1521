main:
	# t0 = x
	# t1 = i
	# t2 = j
	li	$v0, 5			# scanf("%d", &x);
	syscall				#
	move	$t0, $v0
	li	$t1,0			# i = 0

loop1:
	bge	$t1, $t0, end		# if i >= x goto end
	
	li	$t2,0			# j = 0
	b	loop2			# branch to loop2

loop2:
	bge 	$t2,$t0,increaseCount
	

	la	$a0,star		# printf("*");
	li	$v0, 4
	syscall
	addi 	$t2,$t2,1		# j++
	b	loop2			# branch to loop2
	

	

increaseCount: # increase i by 1
	addi	$t1, $t1, 1		# $t1 = $t1 + 1

	li	$a0, '\n'		# printf("%c", '\n');
	li	$v0, 11
	syscall	
	b	loop1			# branch to loop1
	
end:
	li	$v0, 0			# return 0
	jr	$ra

	.data
star:
    .asciiz "*"
