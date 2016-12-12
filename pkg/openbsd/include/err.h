#include_next <err.h>
void warnc(int, const char *, ...) __attribute__((__format__ (printf, 2, 3)));
void vwarnc(int, const char *, va_list) __attribute__((__format__ (printf, 2, 0)));
