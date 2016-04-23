#include_next <unistd.h>
#define pledge(request, paths) 0 /* linux doesn't have pledge */
int getentropy(void *, size_t);
