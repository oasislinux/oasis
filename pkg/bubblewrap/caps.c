#include <assert.h>
#include <limits.h>
#include <string.h>
#include "caps.h"

int
cap_from_name(const char *name)
{
	int i;

	static_assert(sizeof cap_names / sizeof *cap_names <= INT_MAX);
	for (i = 0; i < sizeof cap_names / sizeof *cap_names; ++i) {
		if (cap_names[i] && strcmp(cap_names[i], name) == 0)
			return i;
	}
	return -1;
}
