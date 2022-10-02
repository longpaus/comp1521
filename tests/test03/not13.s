main:
	li	$v0, 5			# scanf("%d", &x);
	syscall				#
	move	$t0, $v0

	li	$v0, 5			# scanf("%d", &y);
	syscall				#
	move	$t1, $v0

	addi	$t0,$t0.1		# i = x + 1

loop:
	bge	$t0,$t1,end		# if i >= y goto end
	bne	$t0, 13, print		# if $t0 != $t1 then print
	b	increaseCount		# branch to increaseCount
	
	
	
print:
	move	$a0, $t0		# printf("%d\n", i);
	li	$v0, 1
	syscall	

	li	$a0, '\n'		# printf("%c", '\n');
	li	$v0, 11
	syscall	
	b	increaseCount		# branch to increaseCount
	
increaseCount:
	addi	$t0,$t0,1		#i++
	b	loop			# branch to loop
	
end:
	li	$v0, 0        		 # return 0
	jr	$ra
