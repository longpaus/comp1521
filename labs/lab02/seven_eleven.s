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

	li 	$t1,1	    # t1 = 1 			

loop:
	bge	$t1, $s0, end	# if t1 >= s0 then target
	rem	$t2,$t1,7	#t2 = t1 % 7 -remainder
	beq	$t2, 0, print	# if(t2 == 0) then print number
	rem	$t2,$t1,11	# t2 = t1 % 11 -remainder
	beq	$t2, 0, print	#if(t2 == 0) then print number

	addi    $t1,$t1,1       # add the counter by 1
    	b       loop            # branch to loop
    	

end:
    	li      $v0, 0
    	jr      $ra             # return 0
print:
	li	$v0,1
	move	$a0, $t1
	syscall
	li      $a0,'\n'    	# printf("%c", '\n');
    	li      $v0,11
	addi    $t1,$t1,1       # add the counter by 1
    	syscall 
	b	loop


.data
prompt:
.asciiz "Enter a number: "
