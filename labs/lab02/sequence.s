# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void)
	la	$a0, prompt1	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall
	li	$v0, 5		# scanf("%d", number);
	syscall
	move 	$t0,$v0		#t0 - starting number


	la	$a0, prompt2	# printf("Enter the stopping number: ");
	li	$v0, 4
	syscall
	li	$v0, 5		# scanf("%d", number);
	syscall
	move 	$t1,$v0		#t1 - stopping number

	la	$a0, prompt3	# printf("Enter the step size: ");
	li	$v0, 4
	syscall
	li	$v0, 5		# scanf("%d", number);
	syscall
	move	$t2,$v0		#t2 - stepping number

	li	$t3,1		#t3 = 1 - counter
	bgt	$t0, $t1, greater	# if start > end then goto greater
	b	less			# branch to less

	

greater:	#for start > stop
	bgt	$t3,$t1,end	#if counter > end then goto end branch
	move	$a0,$t3
	li	$v0,1
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addu	$t3,$t3,$t2	#counter += step
	b	greater		# branch to target
	

less:
	blt	$t3, $t1, end	# if counter < end then goto end
	move	$a0,$t3
	li	$v0,1
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addu	$t3,$t3,$t2
	b	less		# branch to less
	


	
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt1:
	.asciiz "Enter the starting number: "
prompt2:
	.asciiz "Enter the stopping number: "
prompt3:
	.asciiz "Enter the step size: "
