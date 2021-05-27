cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D WITH_ASM',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'blake3.h'}),
	install=true,
}

sub('host.ninja', function()
	set('outdir', '$outdir/host')
	toolchain(config.host)

	lib('libblake3.a', {'blake3.c', 'blake3_dispatch.c', 'blake3_portable.c'})
end)

lib('libblake3.a', [[
	blake3.c
	blake3_dispatch.c
	blake3_portable.c
	@x86_64 (
		blake3_cpuid.S
		blake3_avx2_x86-64_unix.S
		blake3_avx512_x86-64_unix.S
		blake3_sse2_x86-64_unix.S
		blake3_sse41_x86-64_unix.S
	)
]])
file('lib/libblake3.a', '644', '$outdir/libblake3.a')

exe('b3sum', {'b3sum.c', 'libblake3.a'})
file('bin/b3sum', '755', '$outdir/b3sum')

fetch 'git'
