# Reads 10 numbers into an array,
# swaps any pairs of of number which are out of order
# and then prints the 10 numbers
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	#  TODO: add your registers here
	#  - t3 = numbers[i]
	#  - t4 = numbers[i + 1]
	li	$t4,0


scan_loop__init:
	li	$t0, 0				# i = 0;
scan_loop__cond:
	bge	$t0, ARRAY_LEN, scan_loop__end	# while (i < ARRAY_LEN) {

scan_loop__body:
	li	$v0, 5				#   syscall 5: read_int
	syscall					#   
						#
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	sw	$v0, ($t2)			#   scanf("%d", &numbers[i]);

	addi	$t0, $t0, 1			#   i++;
	j	scan_loop__cond			# }
scan_loop__end:


	# TODO: add your code here!
swap_loop_intit:
	li	$t0,1				# i = 0

swap_loop:
	bge	$t0, ARRAY_LEN, print_loop__init	# if $t0 >= ARRAY_LEN then goto print_loop__init
	#get numbers[i]
	mul	$t1,$t0,4
	la	$t2,numbers
	add	$t2,$t2,$t1			# t2 = memory location of numbers[i]
	lw	$t3,0($t2)			# t3 = numbers[i]
	
	#get numbers[i + 1]
	addi	$t1,$t0,-1			# t1 = i - 1
	mul	$t1,$t1,4
	la	$t5,numbers
	add	$t5,$t5,$t1			# t5 = memory location of numbers[i + 1]
	lw	$t4,($t5)			# t4 = numbers[i + 1]

	addi	$t0,$t0,1			# i++

	bge	$t3,$t4,swap_loop		# if numbers[i] >= numbers[i + 1] goto swap_loop (dont swap)

	#swapping
	sw	$t4,($t2)
	sw	$t3,($t5)
	b	swap_loop			# branch to swap_loop
	
	

print_loop__init:
	li	$t0, 0				# i = 0
print_loop__cond:
	bge	$t0, ARRAY_LEN, print_loop__end	# while (i < ARRAY_LEN) {

print_loop__body:
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	lw	$a0, ($t2)			#
	li	$v0, 1				#   syscall 1: print_int
	syscall					#   printf("%d", numbers[i]);

	li	$v0, 11				#   syscall 11: print_char
	li	$a0, '\n'
	syscall					#   printf("%c", '\n');

	addi	$t0, $t0, 1			#   i++
	b	print_loop__cond		# }
print_loop__end:
	
	li	$v0, 0
	jr	$ra				# return 0;

	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
