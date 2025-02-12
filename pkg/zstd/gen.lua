cflags{
	'-Wall', '-Wextra', '-Wpedantic',
	'-include $dir/config.h',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/lib', {'zstd.h', 'zdict.h', 'zstd_errors.h'}),
}
pkg.deps = {
	'$gendir/headers',
	'$dir/config.h',
}

lib('libzstd.a', [[lib/(
	common/(
		debug.c
		entropy_common.c
		error_private.c
		fse_decompress.c
		pool.c
		threading.c
		xxhash.c
		zstd_common.c
	)
	compress/(
		fse_compress.c
		hist.c
		huf_compress.c
		zstd_compress.c
		zstd_compress_literals.c
		zstd_compress_sequences.c
		zstd_compress_superblock.c
		zstd_double_fast.c
		zstd_fast.c
		zstd_lazy.c
		zstd_ldm.c
		zstd_opt.c
		zstdmt_compress.c
	)
	decompress/(
		huf_decompress.c
		@x86_64 huf_decompress_amd64.S
		zstd_ddict.c
		zstd_decompress.c
		zstd_decompress_block.c
	)
)]])

exe('zstd', [[
	programs/(zstdcli.c util.c timefn.c fileio.c fileio_asyncio.c)
	libzstd.a
]])
file('bin/zstd', '755', '$outdir/zstd')
sym('bin/unzstd', 'zstd')
sym('bin/zstdcat', 'zstd')

man{'programs/zstd.1'}

fetch 'git'
