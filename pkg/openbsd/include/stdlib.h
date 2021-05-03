#include_next <stdlib.h>
#include <stdint.h>
void freezero(void *, size_t);
void *recallocarray(void *, size_t, size_t, size_t);
long long strtonum(const char *, long long, long long, const char **);
uint32_t arc4random(void);
uint32_t arc4random_uniform(uint32_t);
void arc4random_buf(void *, size_t);
void setprogname(const char *);
const char *getprogname(void);
extern char *__progname;
