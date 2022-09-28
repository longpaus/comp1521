# Reads 10 numbers into an array
# printing 0 if they are in non-decreasing order
# or 1 otherwise.
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	# t3 = numbers[i]
	# t4 = numbers[i + 1]
	#  TODO: add your registers here
	li	$t5,0				#  - $t5 = 0 : swapped

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

	b	check_loop_init			# branch to check_loop_init
	

	# li	$v0, 1				# syscall 1: print_int
	# li	$a0, 42 			#
	# syscall					# printf("%d", 42)

	# li	$v0, 11				# syscall 11: print_char
	# li	$a0, '\n'			#
	# syscall					# printf("%c", '\n');

	# li	$v0, 0
	# jr	$ra				# return 0;

check_loop_init:
	li	$t0, 0				# i = 0;
check_loop:
	bge	$t0,8,end			#if i > 8 goto end (8 instead of 9 since we are using i + 1)

	#getting numbers[i]
	mul	$t1,$t0,4			# the amount of memory i is at
	la	$t2,numbers
	add	$t2,$t2,$t1			# t2 = location of the integer i
	lw	$t3,0($t2)			# t3 = numbers[i]

	#getting numbers[i + 1]
	addi	$t1,$t0,1			# t1 = i + 1
	mul	$t1,$t1,4
	la	$t2,numbers
	add	$t2,$t2,$t1
	lw	$t4,0($t2)			# t4 = numbers[i + 1]

	addi	$t0,$t0,1			#i++

	ble	$t3, $t4, check_loop		# if $t3 <= $t4 then check_loop

	li	$t5,1				# t5 = 1
	b	end				# branch to end

end:	
	move 	$a0,$t5
	li	$v0,1
	syscall
	li $v0, 0
    	jr $ra

	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
