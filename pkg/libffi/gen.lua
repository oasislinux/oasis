local arch = config.target.platform:match('[^-]*')
cflags{
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir/include',
}

build('sed', '$outdir/include/ffi.h', '$srcdir/include/ffi.h.in', {
	expr={
		'-e s,@VERSION@,3.3,',
		string.format('-e s,@TARGET@,%s,', arch:upper()),
		'-e s,@HAVE_LONG_DOUBLE@,1,',
		'-e s,@HAVE_LONG_DOUBLE_VARIANT@,0,',
		'-e s,@FFI_EXEC_TRAMPOLINE_TABLE@,0,',
	},
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src/'..({x86_64='x86', aarch64='aarch64'})[arch], {'ffitarget.h'}),
	'$outdir/include/ffi.h',
	install=true,
}

pkg.deps = {
	'$gendir/headers',
}

lib('libffi.a', [[
	src/(
		prep_cif.c types.c raw_api.c java_raw_api.c closures.c
		@aarch64 aarch64/(ffi.c sysv.S)
		@x86_64 x86/(ffi64.c unix64.S ffiw64.c win64.S)
	)
]])
file('lib/libffi.a', '644', '$outdir/libffi.a')

fetch 'git'
