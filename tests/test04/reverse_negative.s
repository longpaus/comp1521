# Reads numbers into an array until a negative number is entered
# then print the numbers in reverse order.

# Constants
ARRAY_LEN = 1000				# This is equivalent to a #define in C.

main:
	# Registers:
	#   - $t0: int i
	#   - $t1: temporary result

read_loop__init:
	li	$t0, 0				# i = 0
read_loop__cond:
	bge	$t0, ARRAY_LEN, print_loop	# while (i < ARRAY_LEN) {

read_loop__body:
	li	$v0, 5				#   syscall 5: read_int
	syscall					#   scanf("%d", &x);

	blt	$v0, 0, print_loop		#   if (x < 0) break;

	mul	$t1, $t0, 4			#   &numbers[i] = numbers + 4 * i
	sw	$v0, numbers($t1)		#   numbers[i] = x

	addi	$t0, $t0, 1			#   i++;
	j	read_loop__cond			# }

print_loop:
	ble	$t0, 0, end			# if i <= 0 then end
	sub	$t0, $t0,1			# i--
	
	la	$t3,numbers
	mul	$t2,$t0,4
	add	$t3,$t3,$t2
	lw	$a0, 0($t3)			# 
	
	li	$v0,1
	syscall
	li	$a0,'\n'
	li	$v0,11
	syscall

	 b 	print_loop
	
	
	

	
end:
	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .DATA
	.data
numbers:
	.space 4 * ARRAY_LEN			# int numbers[ARRAY_LEN];
