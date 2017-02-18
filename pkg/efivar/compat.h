#ifndef __bswap_constant_16
#define __bswap_constant_16(x) (((x)<<8&0xff00) | ((x)>>8&0xff))
#endif
#ifndef strndupa
#define strndupa(s, n) ({\
	const char *__s2 = (s);\
	size_t __n = strnlen(__s2, (n));\
	char *__s1 = alloca(__n + 1);\
	__s1[__n] = '\0';\
	(char *)memcpy(__s1, __s2, __n);\
})
#endif
