BOARD_SIZE		= 7

CARRIER_SYMBOL		= 'C'
BATTLESHIP_SYMBOL	= 'B'
DESTROYER_SYMBOL	= 'D'
SUBMARINE_SYMBOL	= 'S'
PATROL_BOAT_SYMBOL	= 'P'

EMPTY			= '-'

.data
# char blue_view[BOARD_SIZE][BOARD_SIZE];
board:			.space  BOARD_SIZE * BOARD_SIZE
# point_t start;
.align 2
start:						# struct point start {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

# point_t end;
.align 2
end:						# struct point end {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }
						
.text
main:
	begin
	push	$ra
	
	li	$t0,0
	la	$a0,start
	sw	$t0,0($a0)			# start.row = 0
	li	$t0,4
	sw	$t0,4($a0)			# start.col = 4
	
	li	$t0,4
	la	$a0,end
	sw	$t0,0($a0)			# end.row = 4
	sw	$t0,4($a0)			# end.col = 4
	
	la	$a0,board
	li	$a1,CARRIER_SYMBOL
	jal	initialise_board
	jal	place_ship_on_board
	la	$a0,board
	
	jal 	print_board

        pop	$ra
	end
	
	li	$v0,0
	jr	$ra
	
################################################################################
.text
place_ship_on_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 = start.row
	#   - $s1 = end.row
	#   - $s2 = start.col
	#   - $s3 = end.col
	#   - $s4 = tempory register
	#   - $s5 = tempory register
	# Structure:
	#   place_ship_on_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

place_ship_on_board__prologue:
	push 	$s0
	push	$s1
	push 	$s2
	push	$s3
	push 	$s4
	push 	$s5

place_ship_on_board__body:
	la	$s0,start
	lw	$s0,0($s0)		# s0 = start.row

	la	$s1,end	
	lw 	$s1,0($s1) 		# s1 = end.row	

	la	$s2,start
	lw	$s2,4($s2)		# s2 = start.col

	la	$s3,end
	lw	$s3,4($s3)		# s3 = end.col

	beq 	$s0,$s1,place_ship_on_board_hori
	b 	place_ship_on_board_vert

place_ship_on_board_hori:
	bgt 	$s2,$s3,place_ship_on_board__epilogue 	#if col > end.col goto end
	mul	$s5,$s0,BOARD_SIZE	#s5 = size from [0][0] to [start.row][0]
	add 	$s4,$a0,$s5		# s4 = & board[start.row][0]
	add 	$s4,$s4,$s2		# s4 = board[start.row][col]
	sb	$a1,0($s4)		# board[start.col][col] = ship_type
	addi 	$s2,$s2,1		# col++
	b 	place_ship_on_board_hori

place_ship_on_board_vert:
	bgt 	$s0,$s1,place_ship_on_board__epilogue  # if row > end.row goto end
	mul 	$s5,$s0,BOARD_SIZE	#s5 = size from [0][0] to [start.row][0]
	add 	$s4,$a0,$s5		# s4 = & board[start.row][0]
	add 	$s4,$s4,$s2		# s4 = board[start.row][col]
	sb	$a1,0($s4)		# board[start.col][col] = ship_type
	addi 	$s0,$s0,1		# row++
	b 	place_ship_on_board_vert

place_ship_on_board__epilogue:
	pop 	$s5
	pop	$s4
	pop 	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	jr	$ra		# return;
	
################################################################################
	
        print_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra, $s0]
	# Uses:     [$a0, $v0, $t0, $t1, $t2, $t3, $t4, $s0]
	# Clobbers: [$a0, $v0, $t0, $t1, $t2, $t3, $t4]
	#
	# Locals:
	#   - $s0: saved $a0
	#   - $t0: col, row
	#   - $t1: col
	#   - $t2: [row][col]
	#   - $t3: &board[row][col]
	#   - $t4: board[row][col]
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#   -> body
	#      -> for_header_init
	#      -> for_header_cond
	#      -> for_header_body
	#      -> for_header_step
	#      -> for_header_post
	#      -> for_row_init
	#      -> for_row_cond
	#      -> for_row_body
	#         -> for_col_init
	#         -> for_col_cond
	#         -> for_col_body
	#         -> for_col_step
	#         -> for_col_post
	#      -> for_row_step
	#      -> for_row_post
	#   -> [epilogue]

print_board__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra
	push	$s0						# | $s0

print_board__body:
	move 	$s0, $a0

	li	$v0, 11						# syscall 11: print_char
	la	$a0, ' '					#
	syscall							# printf("%c", ' ');
	syscall							# printf("%c", ' ');

print_board__for_header_init:
	li	$t0, 0						# int col = 0;

print_board__for_header_cond:
	bge	$t0, BOARD_SIZE, print_board__for_header_post	# if (col >= BOARD_SIZE) goto print_board__for_header_post;

print_board__for_header_body:
	li	$v0, 1						# syscall 1: print_int
	move	$a0, $t0					#
	syscall							# printf("%d", col);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_header_step:
	addiu	$t0, 1						# col++;
	b	print_board__for_header_cond

print_board__for_header_post:
	li	$v0, 11						# syscall 11: print_char
	la	$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_init:
	li	$t0, 0						# int row = 0;

print_board__for_row_cond:
	bge	$t0, BOARD_SIZE, print_board__for_row_post	# if (row >= BOARD_SIZE) goto print_board__for_row_post;

print_board__for_row_body:
	li	$v0, 1						# syscall 1: print_int
	move	$a0, $t0					#
	syscall							# printf("%d", row);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_init:
	li	$t1, 0						# int col = 0;

print_board__for_col_cond:
	bge	$t1, BOARD_SIZE, print_board__for_col_post	# if (col >= BOARD_SIZE) goto print_board__for_col_post;

print_board__for_col_body:
	mul	$t2, $t0, BOARD_SIZE				# &board[row][col] = (row * BOARD_SIZE
	add	$t2, $t2, $t1					#		      + col)
	mul	$t2, $t2, 1					# 		      * sizeof(char)
	add 	$t3, $s0, $t2					# 		      + &board[0][0]
	lb	$t4, ($t3)					# board[row][col]

	li	$v0, 11						# syscall 11: print_char
	move	$a0, $t4					#
	syscall							# printf("%c", board[row][col]);

	li	$v0, 11						# syscall 11: print_char
	li	$a0, ' '					#
	syscall							# printf("%c", ' ');

print_board__for_col_step:
	addi	$t1, $t1, 1					# col++;
	b	print_board__for_col_cond			# goto print_board__for_col_cond;

print_board__for_col_post:
	li	$v0, 11						# syscall 11: print_char
	li	$a0, '\n'					#
	syscall							# printf("%c", '\n');

print_board__for_row_step:
	addi	$t0, $t0, 1					# row++;
	b	print_board__for_row_cond			# goto print_board__for_row_cond;

print_board__for_row_post:
print_board__epilogue:
	pop	$s0						# | $s0
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;
################################################################################
.text
initialise_board:
	# Args:
        #   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 = row
	#   - $s1 = col
	#   - $s2 : tempory register
	#   - $s3 : tempory register
	#   - $s4 = EMPTY
	# Structure:
	#   initialise_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

initialise_board__prologue:
	push	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s4

initialise_board__body:
	li	$s0,0					# row = 0
	b	init_board_Sloop			# branch to init_board_Sloop
	
init_board_Sloop:
	bge 	$s0,BOARD_SIZE,initialise_board__epilogue # if row >= SIZE goto end
	li	$s1,0					# col = 0

init_board_Floop:
	bge 	$s1,BOARD_SIZE,init_board_Sloop_iter	# while(col < BOARD_SIZE)
	mul 	$s2,$s0,BOARD_SIZE			# s2 = size of byte between [0][0] and [row][0]
	add 	$s3,$a0,$s2 				# s3 = &board[row][0]
	add 	$s3,$s3,$s1 				# s3 = &board[row][col]
	la	$s4, EMPTY				
	
	sb 	$s4,0($s3)				# board[row][col] = EMPTY;
	addi 	$s1,$s1,1				# col++
	b 	init_board_Floop


init_board_Sloop_iter:
	addi	$s0,$s0,1				# row++
	b 	init_board_Sloop


initialise_board__epilogue:
	pop	$s4
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	jr	$ra		# return;