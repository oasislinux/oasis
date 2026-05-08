return {
	srcs={
		-- <cd src && printf "\t\t'%s',\n" src/*/riscv64/*.[csS]
		'src/fenv/riscv64/fenv-sf.c',
		'src/fenv/riscv64/fenv.S',
		'src/ldso/riscv64/dlsym.s',
		'src/ldso/riscv64/tlsdesc.s',
		'src/math/riscv64/copysign.c',
		'src/math/riscv64/copysignf.c',
		'src/math/riscv64/fabs.c',
		'src/math/riscv64/fabsf.c',
		'src/math/riscv64/fma.c',
		'src/math/riscv64/fmaf.c',
		'src/math/riscv64/fmax.c',
		'src/math/riscv64/fmaxf.c',
		'src/math/riscv64/fmin.c',
		'src/math/riscv64/fminf.c',
		'src/math/riscv64/sqrt.c',
		'src/math/riscv64/sqrtf.c',
		'src/process/riscv64/vfork.s',
		'src/setjmp/riscv64/longjmp.S',
		'src/setjmp/riscv64/setjmp.S',
		'src/signal/riscv64/restore.s',
		'src/signal/riscv64/sigsetjmp.s',
		'src/thread/riscv64/__set_thread_area.s',
		'src/thread/riscv64/__unmapself.s',
		'src/thread/riscv64/clone.s',
		'src/thread/riscv64/syscall_cp.s',
	},
	bits={
		-- <cd src/arch/riscv64/bits && printf "\t\t'%s',\n" *.h
		'fenv.h',
		'float.h',
		'setjmp.h',
		'signal.h',
		'user.h',
	},
}
		
