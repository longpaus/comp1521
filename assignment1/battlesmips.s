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
# This program was written by <YOUR-NAME-HERE> (YOUR-ZID-HERE)
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
	# TODO: add your code for the `main` function here

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
	# Frame:    [...]
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

initialise_boards__body:
	# TODO: add your code for the `initialise_boards` function here

initialise_boards__epilogue:
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
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   initialise_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

initialise_board__prologue:

initialise_board__body:
	# TODO: add your code for the `initialise_board` function here

initialise_board__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <setup_boards>
.text
setup_boards:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [...]
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

setup_boards__body:
	# TODO: add your code for the `setup_boards` function here

setup_boards__epilogue:
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
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   setup_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

setup_board__prologue:

setup_board__body:
	# TODO: add your code for the `setup_board` function here

setup_board__epilogue:
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
	#   - ...
	#
	# Structure:
	#   place_ship
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

place_ship__prologue:

place_ship__body:
	# TODO: add your code for the `place_ship` function here

place_ship__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <is_coord_out_of_bounds>
.text
is_coord_out_of_bounds:
	# Args:
	#   - $a0: point_t *coord
	#
	# Returns:
	#   - $v0: bool
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   is_coord_out_of_bounds
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_coord_out_of_bounds__prologue:

is_coord_out_of_bounds__body:
	# TODO: add your code for the `is_coord_out_of_bounds` function here

is_coord_out_of_bounds__epilogue:
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
	#   - ...
	#
	# Structure:
	#   is_overlapping
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

is_overlapping__prologue:

is_overlapping__body:
	# TODO: add your code for the `is_overlapping` function here

is_overlapping__epilogue:
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
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   place_ship_on_board
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

place_ship_on_board__prologue:

place_ship_on_board__body:
	# TODO: add your code for the `place_ship_on_board` function here

place_ship_on_board__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <play_game>
.text
play_game:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   play_game
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

play_game__prologue:

play_game__body:
	# TODO: add your code for the `play_game` function here

play_game__epilogue:
	jr	$ra		# return;


################################################################################
# .TEXT <play_turn>
.text
play_turn:
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   play_turn
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

play_turn__prologue:

play_turn__body:
	# TODO: add your code for the `play_turn` function here

play_turn__epilogue:
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
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   perform_hit
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

perform_hit__prologue:

perform_hit__body:
	# TODO: add your code for the `perform_hit` function here

perform_hit__epilogue:
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
	# Frame:    [...]
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
	#   -> [epilogue]

check_winner__prologue:

check_winner__body:
	# TODO: add your code for the `check_winner` function here

check_winner__epilogue:
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
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   check_player_win
	#   -> [prologue]
	#   -> body
	#   -> [epilogue]

check_player_win__prologue:

check_player_win__body:
	# TODO: add your code for the `check_player_win` function here

check_player_win__epilogue:
	jr	$ra		# return;


################################################################################
################################################################################
###                 PROVIDED FUNCTIONS — DO NOT CHANGE THESE                 ###
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
