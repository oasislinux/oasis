#ifdef __aarch64__
#define ARCH_AARCH64 1
#define ARCH_X86_64 0
#define ARCH_X86 0
#endif

#ifdef __x86_64__
#define ARCH_AARCH64 0
#define ARCH_X86 1
#define ARCH_X86_64 1
#endif

#define ARCH_X86_32 0
#define ARCH_ARM 0
#define ARCH_PPC64LE 0
#define CONFIG_16BPC 1
#define CONFIG_8BPC 1
#define CONFIG_LOG 1
#define ENDIANNESS_BIG 0
#define HAVE_ASM 1
#define HAVE_AVX512ICL 1
#define HAVE_CLOCK_GETTIME 1
#define HAVE_DLSYM 1
#define HAVE_POSIX_MEMALIGN 1
#define HAVE_UNISTD_H 1
#define STACK_ALIGNMENT 32
