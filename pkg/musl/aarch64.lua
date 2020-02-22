return {
	srcs={
		-- <cd src && printf "\t\t'%s',\n" src/*/aarch64/*.[sS]
		'src/fenv/aarch64/fenv.s',
		'src/ldso/aarch64/dlsym.s',
		'src/ldso/aarch64/tlsdesc.s',
		'src/setjmp/aarch64/longjmp.s',
		'src/setjmp/aarch64/setjmp.s',
		'src/signal/aarch64/restore.s',
		'src/signal/aarch64/sigsetjmp.s',
		'src/thread/aarch64/__set_thread_area.s',
		'src/thread/aarch64/__unmapself.s',
		'src/thread/aarch64/clone.s',
		'src/thread/aarch64/syscall_cp.s',
	},
	bits={
		-- <cd src/arch/aarch64/bits && printf "\t\t'%s',\n" *.h
		'fcntl.h',
		'fenv.h',
		'float.h',
		'hwcap.h',
		'posix.h',
		'reg.h',
		'setjmp.h',
		'signal.h',
		'stat.h',
		'stdint.h',
		'user.h',
	},
}
