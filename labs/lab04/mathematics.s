# YOUR-NAME-HERE, DD/MM/YYYY

########################################################################
# .DATA
# Here are some handy strings for use in your code.

	.data
prompt_str:
	.asciiz "Enter a random seed: "
result_str:
	.asciiz "The random result is: "

########################################################################
# .TEXT <main>
	.text
main:

	# Args: void
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:
	begin
	push	$ra

main__body:
	li 	$v0,4
	la	$a0,prompt_str
	syscall

	li	$v0,5
	syscall
	move 	$a0, $v0		# $a0 = random_seed

	jal	seed_rand		# seed_rand(random_seed);

	li	$a0,100
	jal	rand			#rand(100)
	move	$a0,$v0

	jal	add_rand		# add_rand(value)
	move	$a0,$v0

	jal	sub_rand		# sub_rand(value)
	move	$a0,$v0

	jal	seq_rand		# seq_rand(value)
	move	$a0,$v0

	push	$a0

	li	$v0,4
	la	$a0,result_str
	syscall

	pop	$a0
	li	$v0,1
	syscall

	li	$v0,11
	li	$a0,'\n'
	syscall

main__epilogue:
	# TODO: add code to clean up stack frame here

	end

	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .TEXT <add_rand>
	.text
add_rand:
	# Args:
	#   - $a0: int value
	# Returns: $v0 int
	#
	# Frame:	[...]
	# Uses: 	[$v0,$a0]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]
	

add_rand__prologue:
	begin
	push	$ra

add_rand__body:
	push	$a0
	li	$a0,0xFFFF
	jal	rand				# jump to r and save position to $ra
	pop	$a0
	add	$v0,$v0,$a0			# return value + rand(0xFFFF)
	

add_rand__epilogue:
	pop 	$ra
	end
	jr	$ra


########################################################################
# .TEXT <sub_rand>
	.text
sub_rand:
	# Args:
	#   - $a0: int value
	# Returns: $v0: int
	#
	# Frame:	[...]
	# Uses: 	[$a0,$v0]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - sub_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

sub_rand__prologue:
	begin
	push	$ra

	# TODO: add code to set up your stack frame here

sub_rand__body:
	jal	rand			# rand(value)
	sub	$v0, $a0, $v0		# return  value - rand(value);

sub_rand__epilogue:
	pop	$ra
	end

	jr	$ra

########################################################################
# .TEXT <seq_rand>
	.text
seq_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - $s0 : limit
	#   - $s1 : i
	# Structure:
	#   - seq_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

seq_rand__prologue:
	begin
	push	$ra
	jal	rand			# limit = rand(100)
	move	$s0,$v0			# s0 = limit
	li	$s1,0			# i = 0
seq_rand__body:
	bge	$s1,$s0,seq_rand__epilogue 	# if i >= limit goto epilogue
	jal	add_rand
	move	$a0,$v0			# value = add_rand
	addi	$s1,$s1,1		# i++
	b 	seq_rand__body		# branch to seq_rand__body

seq_rand__epilogue:
	
	pop	$ra
	end
	jr	$ra



##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following,
## but you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
	.data
	
# int random_seed;
	.align 2
random_seed:
	.space 4


########################################################################
# .TEXT <seed_rand>
	.text
seed_rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:	[]
	# Uses:		[$a0, $t0]
	# Clobbers:	[$t0]
	#
	# Locals:
	#   - $t0: offline_seed
	#
	# Structure:
	#   - seed_rand

	li	$t0, OFFLINE_SEED		# const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0			# random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra				# return;

########################################################################
# .TEXT <rand>
	.text
rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: int rand
	#
	# Structure:
	#   - rand

	lw	$t0, random_seed 		# unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995  		# rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345       		# rand += 12345;
	sw	$t0, random_seed 		# random_seed = rand;

	remu	$v0, $t0, $a0    
	jr	$ra              		# return rand % n;
