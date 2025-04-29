#define __NEED_mode_t
#include_next <string.h>
char *strcasestr(const char *, const char *);
void strmode(mode_t, char *);
int timingsafe_memcmp(const void *, const void *, size_t);
int timingsafe_bcmp(const void *, const void *, size_t);
