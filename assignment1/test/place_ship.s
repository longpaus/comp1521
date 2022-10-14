BOARD_SIZE		= 7

CARRIER_SYMBOL		= 'C'
BATTLESHIP_SYMBOL	= 'B'
DESTROYER_SYMBOL	= 'D'
SUBMARINE_SYMBOL	= 'S'
PATROL_BOAT_SYMBOL	= 'P'

EMPTY			= '-'
TRUE = 1
FALSE = 0
INVALID = -1

.data
red_player_name_str:		.asciiz "RED"
blue_player_name_str:		.asciiz "BLUE"
place_ships_str:		.asciiz ", place your ships!\n"
your_final_board_str:		.asciiz ", Your final board looks like:\n\n"
red_wins_str:			.asciiz "RED wins!\n"
blue_wins_str:			.asciiz "BLUE wins!\n"
red_turn_str:			.asciiz "It is RED's turn!\n"
blue_turn_str:			.asciiz "It is BLUE's turn!\n"
your_curr_board_str:		.asciiz "Your current board:\n"
ship_input_info_1_str:		.asciiz "Placing ship type "
ship_input_info_2_str:		.asciiz ", with length "
ship_input_info_3_str:		.asciiz ".\n"
enter_start_row_str:		.asciiz "Enter starting row: "
enter_start_col_str:		.asciiz "Enter starting column: "
enter_direction_str:		.asciiz "Enter direction (U, D, L, R): "
invalid_direction_str:		.asciiz "Invalid direction. Try again.\n"
invalid_length_str:		.asciiz "Ship doesn't fit in this direction. Try again.\n"
invalid_overlaps_str:		.asciiz "Ship overlaps with another ship. Try again.\n"
invalid_coords_already_hit_str:	.asciiz "You've already hit this target. Try again.\n"
invalid_coords_out_bounds_str:	.asciiz "Coordinates out of bounds. Try again.\n"
enter_row_target_str:		.asciiz "Please enter the row for your target: "
enter_col_target_str:		.asciiz "Please enter the column for your target: "
hit_successful_str: 		.asciiz "Successful hit!\n"
you_missed_str:			.asciiz "Miss!\n"


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
	
	la	$a0,board
	li	$a1,4
	li	$a2,SUBMARINE_SYMBOL
	jal	initialise_board
	jal	place_ship
	
	
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
################################################################################

place_ship_on_board__epilogue:
	pop 	$s5
	pop	$s4
	pop 	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	jr	$ra		# return;
	
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
	
	
################################################################################
# .TEXT <place_ship>
.text
place_ship:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: int  ship_len
	#   - $a2: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0: temp register
	#   - $s1: temp register
	#   - $s2: temp register
	# Structure:
	#   place_ship
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

place_ship__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
place_ship__body:
	push	$a0
	la 	$a0,your_curr_board_str
	li	$v0,4
	syscall					#printf("Your current board:\n");

	pop	$a0
	jal 	print_board			#print_board(board);

	push	$a0
	la	$a0,ship_input_info_1_str
	li	$v0,4
	syscall					#Placing ship type 

	move 	$a0,$a2
	li	$v0,11
	syscall					# print ship type

	la	$a0,ship_input_info_2_str
	li	$v0,4
	syscall					# , with length 

	move	$a0,$a1
	li	$v0,1
	syscall					# print ship len

	la	$a0,ship_input_info_3_str
	li	$v0,4
	syscall					# .\n

	la	$a0,enter_start_row_str
	li	$v0,4
	syscall					#printf("Enter starting row: ");

	li	$v0,5				# scanf("%d", &start.row);
	syscall
	la	$s0,start
	sw	$v0,0($s0)			

	la	$a0,enter_start_col_str
	li	$v0,4
	syscall					#printf("Enter starting column: ");

	li	$v0,5				# scanf("%d", &start.col);
	syscall
	la	$s0,start
	sw	$v0,4($s0)			

	la	$a0,start
	jal	is_coord_out_of_bounds
	beq	$v0,TRUE,place_ship_out_bounds	# is_coord_out_of_bounds(&start)

	la	$a0,enter_direction_str
	li	$v0,4
	syscall					# printf("Enter direction (U, D, L, R): ");

	li	$v0,12
	syscall					# scanf(" %c", &direction_char);

	move 	$s1,$a1				# s1 holds ship_len temporary
	push	$a1
	push 	$a2
	
	la	$s0,start
	lw	$a0,0($s0)			# a0 = start.row

	move	$a1,$v0				# a1 = direction_char
	move	$a2,$s1				# a2 = ship_len

	jal	get_end_row
	la	$s0,end
	sw	$v0,0($s0)			# end.row = get_end_row(start.row, direction_char, ship_len);

	la	$s0,start
	lw	$a0,4($s0)			# a0 = start.col

	jal	get_end_col
	la	$s0,end
	sw	$v0,4($s0)			# end.col = get_end_col(start.col, direction_char, ship_len);

	la	$a0,end

	lw	$s0,0($a0)			# s0 = end.row
	beq 	$s0,INVALID,place_ship_invalid_dir
	lw	$s0,4($a0)			# s0 = end.col
	beq	$s0,INVALID,place_ship_invalid_dir	#if (end.row == INVALID || end.col == INVALID)

	jal	is_coord_out_of_bounds		#if (is_coord_out_of_bounds(&end))
	beq	$v0,TRUE,place_ship_invalid_len

	b 	place_ship_face_up

place_ship_face_up:
	la	$s0,start
	lw	$s0,0($s0)			# s0 = start.row

	la	$s1,end
	lw	$s1,0($s1)			# s1 = end.row

	ble 	$s0,$s1,place_ship_face_left	# if start.row <= end.row goto place_ship_face_left
	la	$s2,start
	sw 	$s1,0($s2)			# start.row = end.row
	la	$s2,end
	sw	$s0,0($s2)			# end.row = temp
	b 	place_ship_face_left

place_ship_face_left:
	la	$s0,start
	lw	$s0,4($s0)			# s0 = start.col

	la	$s1,end
	lw	$s1,4($s1)			# s1 = end.col

	ble 	$s0,$s1,place_ship_is_overlapping
	la	$s2,start
	sw 	$s1,4($s2)			# start.col = end.col
	la	$s2,end
	sw	$s0,4($s2)			# end.col = temp
	b 	place_ship_is_overlapping

place_ship_is_overlapping:
	pop	$a2
	pop	$a1
	pop	$a0
	jal	is_overlapping
	beq 	$v0,FALSE,place_ship__epilogue  # if !is_overlapping(board) then break
	push	$a0
	la	$a0,invalid_overlaps_str
	li	$v0,4
	syscall					# printf("Ship overlaps with another ship. Try again.\n");
	pop 	$a0
	b 	place_ship__body

place_ship_invalid_len:
	la	$a0,invalid_length_str
	li	$v0,4
	syscall					#  printf("Ship doesn't fit in this direction. Try again.\n");
	pop	$a2
	pop	$a1
	pop	$a0
	b 	place_ship__body		# continue

place_ship_invalid_dir:
	la	$a0,invalid_direction_str
	li	$v0,4
	syscall					# printf("Invalid direction. Try again.\n");
	pop	$a2
	pop	$a1
	pop	$a0
	b 	place_ship__body		# continue


place_ship_out_bounds:
	la	$a0,invalid_coords_out_bounds_str
	li	$v0,4
	syscall					#  printf("Coordinates out of bounds. Try again.\n");
	pop	$a0
	b 	place_ship__body		# continue

place_ship__epilogue:
	push	$a1
	move	$a1,$a2				# a1 = ship_type
	jal	place_ship_on_board
	pop	$a1
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <is_coord_out_of_bounds>
.text
is_coord_out_of_bounds:
	# Args:
	#   - $a0: point_t *coord
	#
	# Returns:
	#   - $v0: bool (return 1 if true else 0)
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 = tempory register
	#
	# Structure:
	#   is_coord_out_of_bounds
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_coord_out_of_bounds__prologue:
	push	$s0

is_coord_out_of_bounds__body:
	li	$v0,FALSE
	lw	$s0, 0($a0)		# s0 = coord->row
	blt 	$s0,0,coord_out_of_bounds # if coord->row < 0 return true
	bge 	$s0,BOARD_SIZE,coord_out_of_bounds

	lw	$s0, 4($a0)		# s0 = coord->col
	blt 	$s0,0,coord_out_of_bounds # if coord->col < 0 return true
	bge 	$s0,BOARD_SIZE,coord_out_of_bounds

	b 	is_coord_out_of_bounds__epilogue

	

coord_out_of_bounds:
	li	$v0,TRUE
	b 	is_coord_out_of_bounds__epilogue

is_coord_out_of_bounds__epilogue:
	pop	$s0
	jr	$ra		# return;


################################################################################
# .TEXT <is_overlapping>
.text
is_overlapping:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:
	#   - $v0: bool
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
	#   is_overlapping
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_overlapping__prologue:
	push 	$s0
	push	$s1
	push 	$s2
	push	$s3
	push 	$s4
	push 	$s5
is_overlapping__body:
	li 	$v0,FALSE
	la	$s0,start
	lw	$s0,0($s0)		# s0 = start.row

	la	$s1,end	
	lw 	$s1,0($s1) 		# s1 = end.row	

	la	$s2,start
	lw	$s2,4($s2)		# s2 = start.col

	la	$s3,end
	lw	$s3,4($s3)		# s3 = end.col

	beq 	$s0,$s1,is_overlapping_hori 	# if (start.row == end.row)
	
	b 	is_overlapping_vert
	

is_overlapping_hori:
	bgt 	$s2,$s3, is_overlapping__epilogue	# if col > end.col goto end
	mul	$s5,$s0,BOARD_SIZE	# s5 = size from [0][0] to [start.row][0]
	add	$s4,$a0,$s5 		# s4 = & board[start.row][0]
	add 	$s4,$s4,$s2 		# s4 = &board[start.col][col]
	lb 	$s4,0($s4)		# s4 = board[start.col][col]
	# li 	$s5,EMPTY
	bne 	$s4,EMPTY,overlapping
	addi	$s2,$s2,1		# col++
	b 	is_overlapping_hori

is_overlapping_vert:
	bgt 	$s0,$s1,is_overlapping__epilogue 	# if row > end.row goto end
	mul	$s5,$s0,BOARD_SIZE	#s5 = size from [0][0] to [start.row][0]
	add 	$s4,$a0,$s5		# s4 = & board[start.row][0]
	add 	$s4,$s4,$s2		# s4 = board[start.row][start.col]
	lb	$s4,0($s4)		# s4 = board[start.col][col]
	# li	$s5,EMPTY
	bne 	$s4,EMPTY,overlapping
	addi 	$s0,$s0,1		# row++
	b 	is_overlapping_vert

overlapping:
	li 	$v0,TRUE
	b 	is_overlapping__epilogue
is_overlapping__epilogue:
	pop 	$s5
	pop	$s4
	pop 	$s3
	pop	$s2
	pop 	$s1
	pop 	$s0
	jr	$ra		# return;


################################################################################
################################################################################
# .TEXT <get_end_row>
.text
get_end_row:
	# Args:
	#   - $a0: int  start_row
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_row
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_row__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_row__body:
	move	$v0, $a0					
	beq	$a1, 'L', get_end_row__epilogue			# if (direction == 'L') return start_row;
	beq	$a1, 'R', get_end_row__epilogue			# if (direction == 'R') return start_row;

	sub	$t0, $a2, 1
	sub	$v0, $a0, $t0
	beq	$a1, 'U', get_end_row__epilogue			# if (direction == 'U') return start_row - (ship_len - 1);

	sub	$t0, $a2, 1
	add	$v0, $a0, $t0
	beq	$a1, 'D', get_end_row__epilogue			# if (direction == 'D') return start_row + (ship_len - 1);

	li	$v0, INVALID					# return INVALID;

get_end_row__epilogue:
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;


################################################################################
# .TEXT <get_end_col>
.text
get_end_col:
	# Args:
	#   - $a0: int  start_col
	#   - $a1: char direction
	#   - $a2: int  ship_len
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#
	# Structure:
	#   get_end_col
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

get_end_col__prologue:
	begin							# begin a new stack frame
	push	$ra						# | $ra

get_end_col__body:
	move	$v0, $a0					
	beq	$a1, 'U', get_end_col__epilogue			# if (direction == 'U') return start_col;
	beq	$a1, 'D', get_end_col__epilogue			# if (direction == 'D') return start_col;

	sub	$t0, $a2, 1
	sub	$v0, $a0, $t0
	beq	$a1, 'L', get_end_col__epilogue			# if (direction == 'L') return start_col - (ship_len - 1);

	sub	$t0, $a2, 1
	add	$v0, $a0, $t0
	beq	$a1, 'R', get_end_col__epilogue			# if (direction == 'R') return start_col + (ship_len - 1);

	li	$v0, INVALID					# return INVALID;

get_end_col__epilogue:
	pop	$ra						# | $ra
	end							# ends the current stack frame

	jr	$ra						# return;
