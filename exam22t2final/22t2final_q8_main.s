## ## ## ## ## ## ## ## DO NOT CHANGE THIS FILE! ## ## ## ## ## ## ## ##
## COMP1521 22T2 ... final exam, question 8

NUM_DISKS = 7
SIZEOF_TOWER = NUM_DISKS + 2
SIZEOF_TOWER_2 = SIZEOF_TOWER * 2

	.data
towers:
	.asciiz "gfedcba "
	.asciiz "        "
	.asciiz "        "


	.text
main:
main__prologue:
	begin
	push	$ra

main__body:
	jal	print_towers
	jal	max_size
	move	$a0, $v0

	li	$a1, towers + SIZEOF_TOWER
	li	$a2, towers + 0
	li	$a3, towers + SIZEOF_TOWER_2
	jal	move_disks

main__epilogue:
	pop	$ra
	end

	li	$v0, 0
	jr	$ra



max_size:
	lb	$t0, towers

max_size__for_init:
	li	$t1, 1

max_size__for_cond:
	blt	$t1, 3, max_size__for_body
	b	max_size__for_post

max_size__for_body:
	mul	$t2, $t1, SIZEOF_TOWER
	lb	$t2, towers($t2)
	bgt	$t2, $t0, max_size__new_max
	b	max_size__for_step

max_size__new_max:
	move	$t0, $t2

max_size__for_step:
	addi	$t1, 1
	b	max_size__for_cond

max_size__for_post:
	move	$v0, $t0
	jr	$ra




	.data
print_towers__border:
	.asciiz "================\n"

	.text
print_towers:
	li	$v0, 4
	la	$a0, print_towers__border
	syscall

print_towers__for_i_init:
	li	$t0, 0

print_towers__for_i_cond:
	blt	$t0, 3, print_towers__for_i_body
	b	print_towers__for_i_post

print_towers__for_i_body:
	li	$v0, 11
	li	$a0, '|'
	syscall

print_towers__for_j_init:
	li	$t1, 0

print_towers__for_j_cond:
	blt	$t1, NUM_DISKS, print_towers__for_j_body
	b	print_towers__for_j_post

print_towers__for_j_body:
	mul	$t2, $t0, SIZEOF_TOWER
	add	$t2, $t1
	lb	$t2, towers($t2)

	bnez	$t2, print_towers__print_me
	b	print_towers__print_space

print_towers__print_me:
	li	$v0, 11
	move	$a0, $t2
	syscall

	b	print_towers__print_post

print_towers__print_space:
	li	$v0, 11
	li	$a0, ' '
	syscall

print_towers__print_post:
	li	$v0, 11
	li	$a0, ' '
	syscall

print_towers__for_j_step:
	addi	$t1, 1
	b	print_towers__for_j_cond

print_towers__for_j_post:
	li	$v0, 11
	li	$a0, '|'
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

print_towers__for_i_step:
	addi	$t0, 1
	b	print_towers__for_i_cond

print_towers__for_i_post:
	li	$v0, 4
	la	$a0, print_towers__border
	syscall

	jr	$ra


swap:
	lb	$t0, ($a0)
	lb	$t1, ($a1)

	sb	$t0, ($a1)
	sb	$t1, ($a0)

	jr	$ra
