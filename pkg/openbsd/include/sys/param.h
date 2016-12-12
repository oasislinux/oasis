#include_next <sys/param.h>
#define ALIGNBYTES (sizeof(uintptr_t) - 1)
#define ALIGN(p) (((uintptr_t)(p) + ALIGNBYTES) &~ ALIGNBYTES)
