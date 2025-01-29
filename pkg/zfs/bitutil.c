#include <stdint.h>

/*
 * Find highest one bit set.
 * Returns bit number + 1 of highest bit that is set, otherwise returns 0.
 */
int
highbit64(uint64_t i)
{
	if (i == 0)
		return (0);

	static const char debruijn[64] = {
		 1, 36,  2, 57, 37, 22,  3, 61,
		58, 50, 38, 32, 23, 17,  4, 62,
		55, 59, 30, 53, 51, 45, 39, 33,
		47, 27, 24, 18, 41, 12,  5, 63,
		35, 56, 21, 60, 49, 31, 16, 54,
		29, 52, 44, 46, 26, 40, 11, 34,
		20, 48, 15, 28, 43, 25, 10, 19,
		14, 42,  9, 13,  8,  7,  6, 64
	};
	i |= i >> 1;
	i |= i >> 2;
	i |= i >> 4;
	i |= i >> 8;
	i |= i >> 16;
	i |= i >> 32;
	return (debruijn[(i * 0x03F79C6D30BACA89) >> 58 & 0x3F]);
}

/*
 * Find lowest one bit set.
 * Returns bit number + 1 of lowest bit that is set, otherwise returns 0.
 */
int
lowbit64(uint64_t i)
{
	if (i == 0)
		return (0);

	static const char debruijn[64] = {
		 1,  2, 37,  3, 58, 38, 23,  4,
		62, 59, 51, 39, 33, 24, 18,  5,
		63, 56, 60, 31, 54, 52, 46, 40,
		34, 48, 28, 25, 19, 42, 13,  6,
		64, 36, 57, 22, 61, 50, 32, 17,
		55, 30, 53, 45, 47, 27, 41, 12,
		35, 21, 49, 16, 29, 44, 26, 11,
		20, 15, 43, 10, 14,  9,  8,  7,
	};
	i &= -i;
	return (debruijn[(i * 0x03F79C6D30BACA89) >> 58 & 0x3F]);
}
