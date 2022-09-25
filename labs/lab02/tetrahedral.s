# Read a number n and print the first n tetrahedral numbers
# https://en.wikipedia.org/wiki/Tetrahedral_number
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

#values:
#t0 = how_many
#t1 = n
#t2 = total
#t3 = j
#t4 = i

main:				# int main(void) {

	la	$a0, prompt	# printf("Enter how many: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall

	move	$t0,$v0 	#t0 = how_many
	li	$t1,1		# t1 = 1 - n

loop1Top:
	bgt 	$t1,$t0,end	#if n > how_many goto end
	li	$t2,0		#t2 = 0 - total
	li	$t3,1		#t3 = 1 - j

	ble	$t3,$t1,loop2Top	#if j <= n then goto loop2Top
	b	loop1Bottom	# branch to loop1Bottom
	

loop1Bottom:
	li	$v0,1
	move	$a0,$t2
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addi	$t1,$t1,1	#n++
	b	loop1Top	# branch to loop1Top
	

loop2Top:
	bgt	$t3,$t1,loop1Bottom	#if j > n goto loop1Bottom
	li	$t4,1		#t4 = 1 - i
	ble	$t4,$t3,loop3	#if i <+ j goto loop3
	b	loop2Bottom	# branch to loop2Bottom
	

loop2Bottom:
	addi	$t3,$t3,1	#j++
	b	loop2Top	# branch to loop2Top
	

loop3:
	bgt	$t4,$t3,loop2Bottom	#if i > j goto loop2Bottom
	addu	$t2,$t2,$t4	#total += i
	addi	$t4,$t4,1	#i++



end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter how many: "
