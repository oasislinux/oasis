#define ARCH_AARCH64 0
#define ARCH_ARM 0
#define ARCH_PPC64LE 0
#define ARCH_X86 0
#define ARCH_X86_32 0
#define ARCH_X86_64 0

#ifdef __x86_64__
#undef ARCH_X86
#undef ARCH_X86_64
#define ARCH_X86 1
#define ARCH_X86_64 1
#endif

#define CONFIG_16BPC 1
#define CONFIG_8BPC 1
#define CONFIG_LOG 1
#define ENDIANNESS_BIG 0
#if defined(__x86_64__) && !defined(__ILP32__)
#define HAVE_ASM 1
#define HAVE_AVX512ICL 1
#endif
#define HAVE_CLOCK_GETTIME 1
#define HAVE_DLSYM 1
#define HAVE_POSIX_MEMALIGN 1
#define HAVE_UNISTD_H 1
#define STACK_ALIGNMENT 16
