#ifndef _UTIL_H_
#define _UTIL_H_

#define	FMT_SCALED_STRSIZE	7	/* minus sign, 4 digits, suffix, null byte */

int fmt_scaled(long long, char *);
int scan_scaled(char *, long long *);

#endif
