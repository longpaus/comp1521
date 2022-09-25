# Read a number and print positive multiples of 7 or 11 < n

# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.

# YOUR-NAME-HERE, DD/MM/YYYY

# ![tabsize(8)]

main:                       # int main(void) {

    	la      $a0,prompt  # printf("Enter a number: ");
    	li      $v0,4
    	syscall 

    	li      $v0,5       # scanf("%d", number);
    	syscall 

    	move    $s0, $v0    # s0 = input number

	li 	$t0,1	    # t0 = 1 			

loop:
	bgt	$t0, $s0, end	# if t0 > s0 then target
	rem	$t1,$s0,7	#if(x % 7 == 0)
	beq	$t1, 0, print	# if$t == $t1 then print number
	rem	$t1,$s0,11	#if(x % 11 == 0)
	beq	$t1, 0, print

	addi    $t0,$t0,1       # add the counter by 1
    	b       loop            # branch to loop
    	

end:
    	li      $v0, 0
    	jr      $ra             # return 0
print:
	li	$v0,1
	move	$a0, $v0
	syscall
	li      $a0,'\n'    # printf("%c", '\n');
    	li      $v0,11
    	syscall 


.data
prompt:
.asciiz "Enter a number: "
