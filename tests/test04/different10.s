# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#   - $t0: int x
	#   - $t1: i	
	#   - $t2: int n_seen
	#   - $t3: temporary result
	#   - $t4: temporary result

slow_loop__init:
	li	$t2, 0				# n_seen = 0;
slow_loop__cond:
	bge	$t2, ARRAY_LEN, slow_loop__end	# while (n_seen < ARRAY_LEN) {

slow_loop__body:
	li	$v0, 4				#   syscall 4: print_string
	la	$a0, prompt_str			#
	syscall					#   printf("Enter a number: ");

	li	$v0, 5				#   syscall 5: read_int
	syscall					#
	move	$t0, $v0			#   scanf("%d", &x);

	li	$t1,0				# i = 0

checkLoop:
	bge 	$t1,$t2,slow_loop__end		# if i >= n_seen goto checkLoopIter

	mul	$t3,$t1,4
	la	$a0,number
	add	$a0,$a0,$t3
	lw	$a0,0($a0)
	beq	$t0, $a0, slow_loop__end	# if $t0 == $a0 then slow_loop__end
	addi 	$t1,$t1,1
	b 	checkLoop


	
slow_loop__end:					
	bne 	$t1,$t2,slow_loop__cond

	mul	$t3, $t2, 4			#
	sw	$t0, numbers($t3)		#   numbers[n_seen] = x;

	addi	$t2, $t2, 1			#   n_seen++;
	j	slow_loop__cond


end:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_str			#
	syscall					# printf("10th different number was: ");

	la	$t3,numbers
	add	$t3,$t3,40
	lw	$a0,0($t3)

	li	$v0, 1				# syscall 1: print_int
	syscall					# printf("%d", x);

	li	$v0, 11				# syscall 11: print_char	
	li	$a0, '\n'			#
	syscall					# putchar('\n');

	li	$v0, 0
	jr	$ra				# return 0;

	

########################################################################
# .DATA
	.data
numbers:
	.space 4 * ARRAY_LEN			# int numbers[ARRAY_LEN];
prompt_str:
	.asciiz	"Enter a number: "
result_str:
	.asciiz	"10th different number was: "


