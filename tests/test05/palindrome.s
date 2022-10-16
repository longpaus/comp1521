# Reads a line and prints whether it is a palindrome or not

LINE_LEN = 256

########################################################################
# .TEXT <main>
main:
	# Locals:
	#   - ...

	li	$v0, 4				# syscall 4: print_string
	la	$a0, line_prompt_str		#
	syscall					# printf("Enter a line of input: ");

	li	$v0, 8				# syscall 8: read_string
	la	$a0, line			#
	la	$a1, LINE_LEN			#
	syscall					# fgets(buffer, LINE_LEN, stdin)


	li	$t0,0				# t0 = i
	li	$t1,1

getLenLoop:
	beq 	$t1,0,palindromeLoopInit

	la	$t1,line
	add	$t1,$t1,$t0
	lb	$t1,0($t1)			# t1 = line[i]

	addi 	$t0,$t0,1			# i++
	b	getLenLoop			# branch to getLenLoop


palindromeLoopInit:
	li	$t1,0				# t1 = j
	addi	$t0,$t0,-3			# t0 = k

palindromeLoop:
	bge 	$t1,$t0,palindrome
	la	$t2,line
	add	$t3,$t2,$t1
	lb 	$t3,0($t3)			# t3 = line[j]

	add	$t4,$t2,$t0
	lb 	$t4,0($t4)			# t4 = line[k]

	bne 	$t3,$t4,notPalindrome
	addi 	$t1,$t1,1			# j++
	addi 	$t0,$t0,-1			# k--
	b 	palindromeLoop


notPalindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_not_palindrome_str	#
	syscall					# printf("not palindrome\n");
	li	$v0, 0
	jr	$ra				# return 0;
palindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_palindrome_str	#
	syscall					# printf("palindrome\n");
	li	$v0, 0
	jr	$ra				# return 0;


########################################################################
# .DATA
	.data
# String literals
line_prompt_str:
	.asciiz	"Enter a line of input: "
result_not_palindrome_str:
	.asciiz	"not palindrome\n"
result_palindrome_str:
	.asciiz	"palindrome\n"

# Line of input stored here
line:
	.space	LINE_LEN

