cflags{
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir/include',
}

build('sed', '$outdir/include/ffi.h', '$srcdir/include/ffi.h.in', {
	expr={
		'-e s,@VERSION@,3.3,',
		'-e s,@TARGET@,X86_64,',
		'-e s,@HAVE_LONG_DOUBLE@,1,',
		'-e s,@HAVE_LONG_DOUBLE_VARIANT@,0,',
		'-e s,@FFI_EXEC_TRAMPOLINE_TABLE@,0,',
	},
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src/x86', {'ffitarget.h'}),
	'$outdir/include/ffi.h',
	install=true,
}

lib('libffi.a', [[src/(
	prep_cif.c types.c raw_api.c java_raw_api.c closures.c
	x86/(ffi64.c unix64.S ffiw64.c win64.S)
)]], {'$gendir/headers'})
file('lib/libffi.a', '644', '$outdir/libffi.a')

fetch 'git'
