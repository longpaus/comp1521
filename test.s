main:
    li      $t0,    1               # set the counter to 1
loop:
    bgt     $t0,    10,     end     # if counter > 10 goto end
    li      $v0,    1               # next two lines are for printing the number
    move    $a0,    $t0
    syscall 
    li      $a0,    '\n'            # print newline
    li      $v0,    11
    syscall 
    addi    $t0,    $t0,    1       # add the counter by 1
    b       loop                    # branch to loop
end:
    li      $v0,    0               # end of code
    jr      $ra