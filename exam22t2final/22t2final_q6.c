#include <string.h>
#include <stdlib.h>

/**
 * given a `UTF-8` encoded string,
 * return a new string that is only
 * the characters within the provided range.
 *
 * Note:
 * `range_start` is INCLUSIVE
 * `range_end`   is EXCLUSIVE
 *
 * eg:
 * "hello world", 0, 5
 * would return "hello"
 *
 * "🍓🍇🍈🍍🍐", 2, 5
 * would return "🍈🍍🍐"
**/

char *_22t2final_q6(char *utf8_string, unsigned int range_start, unsigned int range_end) {
	char *new_string = strdup(utf8_string);

	return new_string;
}
