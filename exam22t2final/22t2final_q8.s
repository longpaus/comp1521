# COMP1521 22T2 ... final exam, question 8

	.data

# char default_char = ' ';
default_char:	.byte ' '


	.text
# void move_disks(char size, char *target, char *peg1, char *peg2) {
move_disks:

move_disks_prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push 	$s2
	push 	$s3
	push 	$s4

move_disks_body1:

	la 	$s0,default_char		# s0 = peg_max
	li 	$s1,0				# s1 = source
	li 	$s2,0 				# s2 = other
	move 	$s3,$a0				# s3 = size
	move 	$s4,$a1				# s4 = target
	b 	move_disks_for_init

move_disks_for_init:
	li 	$t0,0 				# t0 = i
	b 	move_disks_for_cond
move_disks_for_cond:
	add 	$t1,$a2,$t0
	lb 	$t1,($t1)			# t1 = peg1[i]
	beq 	$t1,'\0',move_disks_body2
	b 	move_disks_for_body1
move_disks_for_body1:
	ble 	$t1,$s0,move_disks_for_body2
	bgt 	$t1,$s3,move_disks_for_body2
	add 	$s0,$a2,$t0			# peg_max = peg1 + i;
	move 	$s1,$a2				# source = peg1;
	move 	$s2,$a3				# other = peg2;
	b 	move_disks_for_body2

move_disks_for_body2:
	add 	$t1,$a3,$t0
	lb 	$t1,($t1)			# t1 = peg2[i]

	ble 	$t1,$s0,move_disks_for_iter
	bgt 	$t1,$s3,move_disks_for_iter
	add 	$s0,$a3,$t0			# peg_max = peg2 + i;
	move 	$s1,$a3				# source = peg2;
	move 	$s2,$a2				# other = peg1;

	b 	move_disks_for_iter

move_disks_for_iter:
	addi 	$t0,$t0,1			# i++
	b 	move_disks_for_cond

move_disks_body2:
	beq 	$s0,' ',move_disks_epiloque
	addi 	$a0,$s3,-1
	move 	$a1,$s2
	move 	$a2,$s1
	move 	$a3,$s4
	jal 	move_disks

	move 	$a0,$s4
	jal 	find_lowest_target
	move 	$a1,$v0
	move 	$a0,$s0
	jal 	swap
	b 	move_disks_while_cond

move_disks_while_cond:
	addi 	$t0,$s0,1
	beq 	$s0,$t0,move_disks_body3
	b 	move_disks_while_body


move_disks_while_body:
	move 	$a0,$s0
	addi 	$a1,$s0,1
	jal 	swap
	addi 	$s0,$s0,1			# peg_max++;
	b 	move_disks_while_cond

move_disks_body3:
	jal 	print_towers
	addi 	$a0,$s3,-1
	move 	$a1,$s4
	move 	$a2,$s1
	move 	$a3,$s2
	jal 	move_disks
	b 	move_disks_epiloque
move_disks_epiloque:
	
	pop 	$s4
	pop	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	pop 	$ra
	end
	jr	$ra


	.text
# char *find_lowest_target(char *target) {
find_lowest_target:

find_lowest_target_prologue:
	push 	$ra

find_lowest_target_body:
	beq 	$a0,' ',find_lowest_target_epilogue
	addi 	$a0,$a0,1
	jal 	find_lowest_target

find_lowest_target_epilogue:
	pop 	$ra
	end
	move 	$v0,$a0
	jr	$ra
