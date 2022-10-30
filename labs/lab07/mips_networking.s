# Reads a 4-byte value and reverses the byte order, then prints it

########################################################################
# .TEXT <main>
main:
	# Locals:
	#	- $t0: int network_bytes
	#	- $t1: int computer_bytes
	#	- $t2 - int byte_mask


	li	$v0, 5		# scanf("%d", &x);
	syscall
	move	$t0,$v0
	li	$t1,0
	li	$t2,0xFF

	and 	$t3,$t0,$t2	# t3 = network_bytes & byte_mask
	sll 	$t3,$t3,24
	or 	$t1,$t1,$t3	# computer_bytes |= (network_bytes & byte_mask) << 24;

	sll 	$t3,$t2,8	# t3 = byte_mask << 8
	and 	$t3,$t0,$t3	# t3 = network_bytes & (byte_mask << 8)
	sll 	$t3,$t3,8	# t3 = (network_bytes & (byte_mask << 8)) << 8
	or 	$t1,$t1,$t3 	# computer_bytes |= (network_bytes & (byte_mask << 8)) << 8;

	sll 	$t3,$t2,16	# t3 = byte_mask << 16
	and 	$t3,$t0,$t3	# t3 = network_bytes & (byte_mask << 16)
	srl 	$t3,$t3,8	# t3 = (network_bytes & (byte_mask << 16)) >> 8
	or 	$t1,$t1,$t3 	# computer_bytes |= (network_bytes & (byte_mask << 16)) >> 8;

	sll 	$t3,$t2,24	# t3 = byte_mask << 24
	and 	$t3,$t0,$t3	# t3 = network_bytes & (byte_mask << 24)
	srl 	$t3,$t3,24	# t3 = (network_bytes & (byte_mask << 24)) >> 24
	or 	$t1,$t1,$t3 	# computer_bytes |= (network_bytes & (byte_mask << 24)) >> 24;


	#
	# Your code here!
	#

	move	$a0, $t1	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
