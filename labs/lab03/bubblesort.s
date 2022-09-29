# Reads 10 numbers into an array, bubblesorts them
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

scan_loop__init:
	li	$t0, 0				# i = 0
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
	b	scan_loop__cond			# }
scan_loop__end:
	li	$t0,1				# t0 = swapped
	b	loop1				# branch to loop1
	
loop1:
	beq	$t0, 0, print_loop__init	# if swapped == 0 end loop
	li	$t0,0				#swapped = 0
	li	$t1,1				#i = 1
	b	loop2				# branch to loop2

loop2:
	bge	$t1,ARRAY_LEN,loop1		# if i >= arrayLen goto loop1
	#get numbers[i]
	mul	$t2,$t1,4
	la	$t3,numbers
	add	$t3,$t3,$t2			# t3 = memory location numbers[i]
	lw	$t6, 0($t3)			# t6 = numbers[i]

	#get numbers[i - 1]
	addi	$t2,$t1,-1			# t2 = i - 1
	mul	$t2,$t2,4
	la	$t4,numbers
	add	$t4,$t4,$t2			# t4 = memory loaction of numbers[i - 1]
	lw	$t7,0($t4)			# t7 = numbers[i - 1]

	blt	$t6, $t7, swap			# if numbers[i] < nunbers[i - 1] goto swap	
	b	loop2_increase_count		# branch to loop2_increase_count
	

swap:
	sw	$t6,($t4)			# numbers[i - 1] = x
	sw	$t7,($t3)			# nunbers[i] = y
	li	$t0,1				#swapped = 1
	b	loop2_increase_count		# branch to loop2_increase_count
	


loop2_increase_count:
	addi	$t1,$t1,1			# i++
	b	loop2				# branch to loop2


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
	li	$a0, '\n'			#
	syscall					#   printf("%c", '\n');

	addi	$t0, $t0, 1			#   i++
	b	print_loop__cond		# }
print_loop__end:
	
	li	$v0, 0
	jr	$ra				# return 0;


	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
