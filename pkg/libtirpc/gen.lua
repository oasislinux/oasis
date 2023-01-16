cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _BSD_SOURCE',
	'-D INET6',
	'-I $outdir/include',
	'-I $srcdir/tirpc',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/tirpc', {
	'netconfig.h',
	'rpc/types.h',
	'rpc/xdr.h',
})
pkg.deps = {'$gendir/headers'}

lib('libtirpc.a', [[
	src/(
		xdr.c
		xdr_rec.c
		xdr_array.c
		xdr_float.c
		xdr_mem.c
		xdr_reference.c
		xdr_stdio.c
		xdr_sizeof.c
	)
]])

fetch 'git'
