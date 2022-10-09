
main:

sum:       
        # Args:
	#   - $a0: int value
	# Returns: $v0 int
	#
	# Frame:	[...]
	# Uses: 	[$v0,$a0]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]
sumProlouge:
        begin
        push    $ra

sumBody:
        bge     $a0,101,
