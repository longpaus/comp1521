# Reads a line and print its length

LINE_LEN = 256

########################################################################
# .TEXT <main>
main:
	# Locals:
	#   - t0 = i

	li	$v0, 4			# syscall 4: print_string
	la	$a0, line_prompt_str	#
	syscall				# printf("Enter a line of input: ");

	li	$v0, 8			# syscall 8: read_string
	la	$a0, line		#
	la	$a1, LINE_LEN		#
	syscall				# fgets(buffer, LINE_LEN, stdin)

	

	li	$t0,1			# t0 = i
	li	$t1,1
loop:	
	beq 	$t1,0,end

	la	$t1,line
	add	$t1,$t1,$t0
	lb	$t1,0($t1)		# t1 = line[i]

	addi 	$t0,$t0,1		# i++

end:
	li	$v0, 4			# syscall 4: print_string
	la	$a0, result_str		#
	syscall				# printf("Line length: ");

	move	$a0,$t0
	li	$v0,1
	syscall

	li	$v0, 11			# syscall 11: print_char
	li	$a0, '\n'		#
	syscall				# putchar('\n');

	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .DATA
	.data
# String literals
line_prompt_str:
	.asciiz	"Enter a line of input: "
result_str:
	.asciiz	"Line length: "

# Line of input stored here
line:
	.space	LINE_LEN

