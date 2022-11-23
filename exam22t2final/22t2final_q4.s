	.data
numbers:
	.word 0:10	# int numbers[10] = { 0 };

	.text
main:
	li	$t0, 0		# i = 0;

main__input_loop:
	bge	$t0, 10, main__input_finished	# while (i < 10) {

	li	$v0, 5			# syscall 5: read_int
	syscall
	mul	$t1, $t0, 4
	sw	$v0, numbers($t1)	#	scanf("%d", &numbers[i]);
	
	addi	$t0, 1			#	i++;
	b	main__input_loop	# }

main__input_finished:
	li 	$t0,1			# max_run = 1;
	li 	$t1,1			# current_run = 1
	li 	$t2,1 			# i = 1

loopPart1:
	bge 	$t2,10,main__print
	addi 	$t3,$t2,-1		# t3 = i - 1
	mul 	$t4,$t2,4
	mul 	$t5,$t3,4
	la 	$t6,numbers
	add 	$t4,$t6,$t4		# t4 = &numbers[i]
	add 	$t5,$t6,$t5 		# t5 = &numbers[i - 1]
	lw 	$t4,0($t4)		# t4 = numbers[i]
	lw 	$t5,0($t5)		# t5 = numbers[i - 1]

	bgt 	$t4,$t5,increaseCurrRun
	li 	$t1,1 			# current_run = 1
	b 	loopPart2

increaseCurrRun:
	addi 	$t1,$t1,1		# current_run++
	b 	loopPart2

loopPart2:
	ble 	$t1,$t0,loopIter
	move 	$t0,$t1
	loopIter

loopIter:
	addi 	$t2,$t2,1		# i++
	b 	loopPart1


main__print:
	li	$v0, 1		# syscall 1: print_int
	move	$a0, $t0
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");

	li	$v0, 0
	jr	$ra		# return 0;
