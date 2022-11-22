# COMP1521 22T2 ... final exam, question 2

main:
	li	$v0, 5		# syscall 5: read_int
	syscall
	move	$t0, $v0	# read integer into $t0

	li	$t1,0		# count = 0
	li	$t2,0		# i = 0
loop:
	bgt 	$t2,32,main__end
	andi 	$t3,$t0,1
	beq 	$t3,0,increase_count
	b 	counter

increase_count:
	addi 	$t1,$t1,1	#count++
	b 	counter


counter:
	addi	$t2,$t2,1	# i++
	srl 	$t0,$t0,1	# x >>= 1
	b 	loop
	

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
