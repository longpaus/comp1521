#include <stdint.h>

/**
 * Return the provided value but with its bytes reversed.
 *
 * For example, 22t2final_q3(0x12345678) => 0x78563412
 *
 * *Note* that your task is to
 * reverse the order of *bytes*,
 * *not* to reverse the order of bits.
 **/

uint32_t _22t2final_q3(uint32_t value) {
	uint32_t mask, tmp;
	uint32_t reverse = 0;
	for (int i = 0; i < 4; i++) {
		mask = ((uint32_t)1 << 8) - 1;
		tmp = value & mask;
		reverse |= tmp;
		if (i < 3)
			reverse <<= 8;
		value >>= 8;
	}
	return reverse;
}
