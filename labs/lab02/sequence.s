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

	move	$t3,$t0		#t3 = t0 - counter
	blt	$t0, $t1,less			# branch to less
	bgt	$t0, $t1, greater	# if start > end then goto greater

	
greater:	#for start > stop
	bgt	$t2,0,end	#if step > 0 goto end
	blt	$t3, $t1, end	# if counter < end then goto end
	

	move	$a0,$t3
	li	$v0,1
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addu	$t3,$t3,$t2
	b	greater		# branch to less
	



less:	#for start < stop
	blt	$t2,0,end	#if step < 0 goto end
	bgt	$t3,$t1,end	#if counter > end then goto end branch
	move	$a0,$t3
	li	$v0,1
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addu	$t3,$t3,$t2	#counter += step
	b	less		# branch to target
	


	
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
