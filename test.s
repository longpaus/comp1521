ARR_ROW_LEN = 4
ARR_COL_LEN = 3
main:
        li  	$t0,0                   # i = 0
loop1:
        bge     $t0,ARR_ROW_LEN,end
        li      $t1,0                   # j = 0
        b	loop2			# branch to loop2
        b	loop1End		# branch to loop1End
        

loop2:
        bge     $t1,ARR_COL_LEN,loop1End         # if j >= colLen goto
        #get the memory address of the first value in the row into t2
        li      $t6,ARR_COL_LEN
        mul     $t6,$t6,4
        mul     $t2,$t0,$t6                     #t2 = adding address of numbers[i][0]
        mul     $t3,$t1,4
        add     $t2,$t2,$t3                     #t2 = adding address of numbers[i][j]
        la      $t4,numbers
        add     $t4,$t4,$t2                     #t4 = address of numbers[i][j]

        lw      $a0,0($t4)                      #printf("%d",arr[i][j])
        li      $v0,1
        syscall

        addi    $t1,$t1,1                       #j++
        b	loop2			        # branch to loop2

loop1End:
        li      $v0,11
        li      $a0,'\n'
        syscall
        addi    $t0,$t0,1                       #i++
        b	loop1			        # branch to loop1
        
        
    
end:
        li      $v0,    0
        jr      $ra                     # return 0
    

    .data
numbers:
        #int numbers[4][3] = {{1,2,3},{4,5,6},{7,8,9},{0,0,0}}
	.word	1,2,3,4,5,6,7,8,9,0,0,0       