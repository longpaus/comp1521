# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 1000

main:
	# t0 = i
	# t1 = prime[i]
	# t2 = j
	li	$t0, 2			# i = 2	 
	
loop1:
	bge	$t0, ARRAY_LEN, end	# if $t0 >= ARRAY_LENt1 then end
	# get prime[i]
	la	$t1,prime
	add	$t1,$t1,$t0		
	lb	$t1, 0($t1)		# t1 = prime[i]
	beq	$t1, 1, print		# if prime[i] == 1 then loop2
	b 	loop1Iter		# branch to loop1Iter

loop1Iter:
	addi	$t0, $t0, 1		# i++
	b 	loop1			# branch to loop1
	

print:
	li	$v0,1
	move 	$a0,$t0
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	b	loop2Init		# branch to loop2Init

loop2Init:
	mul	$t2,$t0,2		# j = i * 2
	b	loop2			# branch to loop2
	

loop2:
	bge 	$t2,ARRAY_LEN,loop1Iter #if j >= ARRAY_LEN goto loop1Iter
	#get prime[j]
	la	$t1,prime
	add	$t1,$t1,$t2	
	li	$t7,0	
	sb	0, 0($t1)		# prime[j] = 0

	add	$t2,$t2,$t0		# j += i
	b	loop2			# branch to loop2
	
	
		
	

end:
	li	$v0, 0
	jr	$ra			# return 0;

	.data
prime:
	.byte	1:ARRAY_LEN		# uint8_t prime[ARRAY_LEN] = {1, 1, ...};
