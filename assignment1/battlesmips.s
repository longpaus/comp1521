########################################################################
# COMP1521 22T3 -- Assignment 1 -- Battlesmips!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/22T3/resources/mips-editors.html
# !!! IMPORTANT !!!
#
# A simplified implementation of the classic board game battleship!
# This program was written by <long pham> (z5417369)
# on DATE-FINISHED-HERE
#
# Version 1.0 (2022/10/04): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
################################################################################

#![tabsize(8)]

# Constant definitions.
# DO NOT CHANGE THESE DEFINITIONS

# True and False constants
TRUE			= 1
FALSE			= 0
INVALID			= -1

# Board dimensions
BOARD_SIZE		= 7

# Bomb cell types
EMPTY			= '-'
HIT			= 'X'
MISS			= 'O'

# Ship cell types
CARRIER_SYMBOL		= 'C'
BATTLESHIP_SYMBOL	= 'B'
DESTROYER_SYMBOL	= 'D'
SUBMARINE_SYMBOL	= 'S'
PATROL_BOAT_SYMBOL	= 'P'

# Ship lengths
CARRIER_LEN		= 5
BATTLESHIP_LEN		= 4
DESTROYER_LEN		= 3
SUBMARINE_LEN		= 3
PATROL_BOAT_LEN		= 2

# Players
BLUE			= 'B'
RED			= 'R'

# Direction inputs
UP			= 'U'
DOWN			= 'D'
LEFT			= 'L'
RIGHT			= 'R'

# Winners
WINNER_NONE		= 0
WINNER_RED		= 1
WINNER_BLUE		= 2


################################################################################
# DATA SEGMENT
# DO NOT CHANGE THESE DEFINITIONS
.data

# char blue_board[BOARD_SIZE][BOARD_SIZE];
blue_board:			.space  BOARD_SIZE * BOARD_SIZE

# char red_board[BOARD_SIZE][BOARD_SIZE];
red_board:			.space  BOARD_SIZE * BOARD_SIZE

# char blue_view[BOARD_SIZE][BOARD_SIZE];
blue_view:			.space  BOARD_SIZE * BOARD_SIZE

# char red_view[BOARD_SIZE][BOARD_SIZE];
red_view:			.space  BOARD_SIZE * BOARD_SIZE

# char whose_turn = BLUE;
whose_turn:			.byte   BLUE

# point_t target;
.align 2
target:						# struct point target {
				.space  4	# 	int row;
				.space  4	# 	int col;
						# }

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

# Strings
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


############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################


################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  - [ ] main
#  - [ ] initialise_boards
#  - [ ] initialise_board
#  - [ ] setup_boards
#  - [ ] setup_board
#  - [ ] place_ship
#  - [ ] is_coord_out_of_bounds
#  - [ ] is_overlapping
#  - [ ] place_ship_on_board
#  - [ ] play_game
#  - [ ] play_turn
#  - [ ] perform_hit
#  - [ ] check_player_win
#  - [ ] check_winner
#  - [X] print_board			(provided for you)
#  - [X] swap_turn			(provided for you)
#  - [X] get_end_row			(provided for you)
#  - [X] get_end_col			(provided for you)
################################################################################

################################################################################
# .TEXT <main>
.text
main:
	# Args:     void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra, ...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   main
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

main__prologue:
	begin			# begin a new stack frame
	push	$ra		# | $ra

main__body:
	jal 	initialise_boards
	jal	setup_boards
	jal	play_game

main__epilogue:
	pop	$ra		# | $ra
	end			# ends the current stack frame

	li	$v0, 0
	jr	$ra		# return 0;


################################################################################
# .TEXT <initialise_boards>
.text
initialise_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   initialise_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

initialise_boards__prologue:
	begin	
	push	$ra
initialise_boards__body:
	la	$a0,blue_board
	jal	initialise_board

	la	$a0,blue_view
	jal 	initialise_board

	la	$a0,red_board
	jal 	initialise_board

	la	$a0,red_view
	jal 	initialise_board

initialise_boards__epilogue:
	pop 	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <initialise_board>
.text
initialise_board:
	# Args:
        #   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#
	# Returns:  void
	#
	# Frame:    [$ra,$s0,$s1,$s2,$s3,$s4]
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
	# 	-> init_Sloop
	# 	-> init_Floop
	# 	-> Slow_loop_iter
	#   -> [epilogue]

initialise_board__prologue:
	begin
	push 	$ra
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
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <setup_boards>
.text
setup_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra,$a0]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   setup_boards
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_boards__prologue:
	begin
	push	$ra
	push	$a0
setup_boards__body:
	la	$a0,blue_board
	la	$a1,blue_player_name_str
	jal	setup_board

	la	$a0,red_board
	la	$a1,red_player_name_str
	jal	setup_board

setup_boards__epilogue:
	pop	$a0
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <setup_board>
.text
setup_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char *player
	#
	# Returns:  void
	#
	# Frame:    [$ra,$a0]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 : store $a0
	#
	# Structure:
	#   setup_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_board__prologue:
	begin
	push	$ra
	push	$s0

setup_board__body:
	push	$a0
	move	$a0,$a1
	li	$v0,4
	syscall					# print player
	la	$a0,place_ships_str
	li	$v0,4
	syscall					#  printf("%s, place your ships!\n", player);
	pop	$a0
	push	$a1

	li	$a1,CARRIER_LEN
	li	$a2,CARRIER_SYMBOL
	move	$s0,$a0
	jal	place_ship			#  place_ship(board, CARRIER_LEN, CARRIER_SYMBOL);

	li	$a1,BATTLESHIP_LEN
	li	$a2,BATTLESHIP_SYMBOL
	move	$a0,$s0
	jal	place_ship			# place_ship(board, BATTLESHIP_LEN, BATTLESHIP_SYMBOL);

	li	$a1,DESTROYER_LEN
	li	$a2,DESTROYER_SYMBOL
	move	$a0,$s0
	jal	place_ship			# place_ship(board, DESTROYER_LEN, DESTROYER_SYMBOL);

	li	$a1,SUBMARINE_LEN
	li	$a2,SUBMARINE_SYMBOL		
	move	$a0,$s0
	jal	place_ship			#   place_ship(board, SUBMARINE_LEN, SUBMARINE_SYMBOL);

	li	$a1,PATROL_BOAT_LEN
	li	$a2,PATROL_BOAT_SYMBOL
	move	$a0,$s0
	jal	place_ship			#  place_ship(board, PATROL_BOAT_LEN, PATROL_BOAT_SYMBOL); 

	pop	$a1
	push	$a0
	move	$a0,$a1
	li	$v0,4
	syscall					# print player
	la	$a0,your_final_board_str
	li	$v0,4
	syscall					# printf("%s, Your final board looks like:\n\n", player);
	pop	$a0
	jal	print_board			# print_board(board);


setup_board__epilogue:
	pop	$s0
	pop	$ra
	end
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
	# Frame:    [$ra,$a0,$a1,$a2]
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
	#	-> out_bounds
	#	-> invalid_dir
	#	-> invalid_len
	#	-> face_up
	#	-> face left
	# 	-> is_overlapping
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
	move	$s0,$a0
	jal 	print_board			#print_board(board);
	move	$a0,$s0

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
	# Frame:    [$ra,$s0]
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
	#	-> out_bounds
	#   -> [epilogue]

is_coord_out_of_bounds__prologue:
	begin
	push	$ra
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
	pop	$ra
	end
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
	# Frame:    [$ra]
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
	#	-> hori
	#	-> vert
	#		-> overlapping
	#   -> [epilogue]

is_overlapping__prologue:
	begin
	push	$ra
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
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <place_ship_on_board>
.text
place_ship_on_board:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] board
	#   - $a1: char ship_type
	#
	# Returns:  void
	#
	# Frame:    [$ra]
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
	#	-> hori
	#	-> vert
	#   -> [epilogue]

place_ship_on_board__prologue:
	begin
	push	$ra
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
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [$a0]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 : winner
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body1
	#   -> loop
	#   -> body2
	#	-> blue_win
	#	-> red_win
	#   -> [epilogue]

play_game__prologue:
	begin
	push	$ra
	push	$s0

play_game__body1:
	li	$s0,WINNER_NONE			# s0 = winner

play_game_loop:
	bne 	$s0,WINNER_NONE,play_game__body2
	jal	play_turn
	jal	check_winner
	move	$s0,$v0
	b 	play_game_loop

play_game__body2:
	beq 	$s0,WINNER_RED,play_game_red_win
	b 	play_game_blue_win

play_game_blue_win:
	la	$a0,blue_wins_str
	li	$v0,4
	syscall
	b 	play_game__epilogue

play_game_red_win:
	la	$a0,red_wins_str
	li	$v0,4
	syscall
	b 	play_game__epilogue


play_game__epilogue:
	pop	$s0
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 : whose_turn
	#   - $s1 : hit_status
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> body1
	#	->red_turn
	#	-> blue_turn
	#   -> body2
	#	-> out_bounds
	#	-> blue_turn2
	#	->red_turn2
	#   -> body3
	#	-> hit_stat_inval
	#	-> hit_stat_hit
	#   -> [epilogue]

play_turn__prologue:
	begin
	push	$ra
	push	$s0
	push 	$s1

play_turn__body1:
	la	$s0,whose_turn
	lb	$s0,0($s0)			# s0 = whose_turn
	beq 	$s0,BLUE,play_turn_blue_turn
	b	play_turn_red_turn		# branch to play_turn_red_turn
		

play_turn__body2:
	la	$a0,enter_row_target_str
	li	$v0,4
	syscall					#  printf("Please enter the row for your target: ");
	li	$v0,5	
	syscall					
	la	$s0,target
	sw 	$v0,0($s0)			# scanf("%d", &target.row);

	la	$a0,enter_col_target_str
	li	$v0,4
	syscall					# printf("Please enter the column for your target: ");
	li	$v0,5
	syscall
	la	$s0,target
	sw	$v0,4($s0)			# scanf("%d", &target.col);

	la	$a0,target
	jal	is_coord_out_of_bounds
	beq 	$v0,TRUE,play_turn_out_bounds

	la	$s0,whose_turn
	lb	$s0,0($s0)			# s0 = whose_turn

	beq 	$s0,BLUE,play_turn_blue_turn2
	b 	play_turn_red_turn2

play_turn__body3:
	beq	$s1,INVALID,play_turn_hit_stat_inval
	beq 	$s1,HIT,play_turn_hit_stat_hit

	la	$a0,you_missed_str
	li	$v0,4
	syscall					# printf("Miss!\n");

	jal	swap_turn
	b 	play_game__epilogue


play_turn_hit_stat_hit:
	la	$a0,hit_successful_str
	li	$v0,4
	syscall					#  printf("Successful hit!\n");
	b 	play_turn__epilogue


play_turn_hit_stat_inval:
	la 	$a0,invalid_coords_already_hit_str
	li	$v0,4
	syscall					# printf("You've already hit this target. Try again.\n");
	b 	play_turn__epilogue

play_turn_red_turn2:
	la	$a0,blue_board
	la	$a1,red_view
	jal	perform_hit
	move	$s1,$v0				# s1 = hit_status
	b 	play_turn__body3

play_turn_blue_turn2:
	la	$a0,red_board
	la	$a1,blue_view
	jal	perform_hit
	move	$s1,$v0				# s1 = hit_status
	b 	play_turn__body3

play_turn_out_bounds:
	la	$a0,invalid_coords_out_bounds_str
	li	$v0,4
	syscall					#  printf("Coordinates out of bounds. Try again.\n");
	b 	play_turn__epilogue


play_turn_red_turn:
	la	$a0,red_turn_str
	li	$v0,4
	syscall
	la	$a0,red_view
	jal	print_board
	b 	play_turn__body2

play_turn_blue_turn:
	la	$a0,blue_turn_str
	li	$v0,4
	syscall
	la	$a0,blue_view
	jal	print_board
	b 	play_turn__body2



play_turn__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra		# return 0;


################################################################################
# .TEXT <perform_hit>
.text
perform_hit:
	# Args:
	#   - $a0: char their_board[BOARD_SIZE][BOARD_SIZE]
	#   - $a1: char our_view[BOARD_SIZE][BOARD_SIZE]
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 : temp register
	#   - $s1 : target.row
	#   - $s2 : target.col
	#   - $s3 : our_view[target.row][target.col]
	#   - $s4 : temp register
	#   - $s5 : their_board[target.row][target.col]
	#   - $s6 : temp register
	#
	# Structure:
	#   perform_hit
	#   -> [prologue]
	#   -> body
	#	->invalid
	#	->hit
	#   -> [epilogue]

perform_hit__prologue:
	begin
	push	$ra
	push 	$s0
	push	$s1
	push 	$s2
	push	$s3
	push 	$s4
	push 	$s5
	push	$s6

perform_hit__body:
	la	$s0,target
	lw	$s1,0($s0)			# s1 = target.row
	lw	$s2,4($s0)			# s2 = target.col

	mul	$s0,$s1,BOARD_SIZE
	add	$s0,$a1,$s0			# s0 = &our_view[target.row][0]
	add	$s0,$s0,$s2			# s0 = &our_view[target.row][target.col]
	lb	$s3,0($s0)			# s3 = our_view[target.row][target.col]
	bne 	$s3,EMPTY,perform_hit_invalid

	mul	$s4,$s1,BOARD_SIZE
	add	$s4,$s4,$a0			# s4 = &their_board[target.row][0]
	add	$s4,$s4,$s2			# s4 = &their_board[target.row][target.col]
	lb	$s5,0($s4)			# s5 = their_board[target.row][target.col]
	bne 	$s5,EMPTY,perform_hit_hit

	li	$s6,MISS
	sb	$s6,0($s0)			# our_view[target.row][target.col] = MISS;
	li	$v0,MISS
	b 	perform_hit__epilogue

perform_hit_invalid:
	li	$v0,INVALID
	b 	perform_hit__epilogue

perform_hit_hit:
	li	$s6,HIT
	sb	$s6,0($s0)			# our_view[target.row][target.col] = HIT;
	li	$v0,HIT
	b	perform_hit__epilogue


perform_hit__epilogue:
	pop 	$s6
	pop 	$s5
	pop 	$s4
	pop 	$s3
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <check_winner>
.text
check_winner:
	# Args:	    void
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   check_winner
	#   -> [prologue]
	#   -> body
	#	-> red_win
	#	-> blue_win
	#   -> [epilogue]

check_winner__prologue:
	begin
	push	$ra

check_winner__body:
	la 	$a0,red_board
	la	$a1,blue_view
	jal	check_player_win
	beq	$v0,TRUE,check_winner_blue_win

	la	$a0,blue_board
	la	$a1,red_view
	jal	check_player_win
	beq 	$v0,TRUE,check_winner_red_win

	li 	$v0,WINNER_NONE
	b 	check_winner__epilogue

check_winner_red_win:
	li	$v0,WINNER_RED
	b 	check_winner__epilogue

check_winner_blue_win:
	li	$v0,WINNER_BLUE
	b 	check_winner__epilogue

check_winner__epilogue:
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
# .TEXT <check_player_win>
.text
check_player_win:
	# Args:
	#   - $a0: char[BOARD_SIZE][BOARD_SIZE] their_board
	#   - $a1: char[BOARD_SIZE][BOARD_SIZE] our_view
	#
	# Returns:
	#   - $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - $s0 : row
	#   - $s1 : col
	#   - $s2 : size from [0][0] to [row][0] in an array
	#   - $s3 : temp register
	# Structure:
	#   check_player_win
	#   -> [prologue]
	#   -> sLoop_init
	#   -> sLoop_cond
	#	-> epilogue
	#   -> sLoop_body
	#	-> fLoop_cond
	#		-> sLoop_iter
	#		-> fLoop_body
	#			-> sLoop_iter
	#   -> [epilogue]

check_player_win__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
check_player_win_sLoop_init:
	li	$v0,TRUE
	li	$s0,0				# row = 0

check_player_win_sLoop_cond:
	bge	$s0, BOARD_SIZE,check_player_win__epilogue
	b 	check_player_win_sLoop_body

check_player_win_sLoop_body:
	li	$s1,0				# col = 0
	b 	check_player_win_fLoop_cond

check_player_win_fLoop_cond:
	bge 	$s1,BOARD_SIZE,check_player_win_sLoop_iter
	b 	check_player_win_fLoop_body

check_player_win_fLoop_body:
	mul 	$s2,$s0,BOARD_SIZE		# s2 = size from [0][0] to [row][0]
	add	$s3,$a0,$s2			# s3 = &their_board[row][0]
	add	$s3,$s3,$s1
	lb 	$s3,0($s3)			# s3 = &their_board[row][col]			
	beq	$s3,EMPTY,check_player_win_fLoop_iter	# if their_board[row][col] == EMPTY goto iter

	add	$s3,$a1,$s2			# s3 = &our_view[row][0]
	add	$s3,$s3,$s1
	lb 	$s3,0($s3)			# s3 = our_view[row][col]
	bne 	$s3,EMPTY,check_player_win_fLoop_iter	# if our_view[row][col] != EMPTY goto iter

	li	$v0,FALSE
	b 	check_player_win__epilogue


check_player_win_sLoop_iter:
	addi	$s0,$s0,1			# row++
	b 	check_player_win_sLoop_cond

check_player_win_fLoop_iter:
	addi 	$s1,$s1,1			# col++
	b 	check_player_win_fLoop_cond


check_player_win__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra		# return;


################################################################################
################################################################################
###                 PROVIDED FUNCTIONS ??? DO NOT CHANGE THESE                 ###
################################################################################
################################################################################


################################################################################
# .TEXT <print_board>
# YOU DO NOT NEED TO CHANGE THE PRINT_BOARD FUNCTION
.text
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
# .TEXT <swap_turn>
.text
swap_turn:
	# Args:	    void
	#
	# Returns:  void
	#
	# Frame:    []
	# Uses:     [$t0]
	# Clobbers: [$t0]
	#
	# Locals:
	#
	# Structure:
	#   swap_turn
	#   -> body
	#      -> red
	#      -> blue
	#   -> [epilogue]

swap_turn__body:
	lb	$t0, whose_turn
	bne	$t0, BLUE, swap_turn__blue			# if (whose_turn != BLUE) goto swap_turn__blue;

swap_turn__red:
	li	$t0, RED					# whose_turn = RED;
	sb	$t0, whose_turn					# 
	
	j	swap_turn__epilogue				# return;

swap_turn__blue:
	li	$t0, BLUE					# whose_turn = BLUE;
	sb	$t0, whose_turn					# 

swap_turn__epilogue:
	jr	$ra						# return;

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
