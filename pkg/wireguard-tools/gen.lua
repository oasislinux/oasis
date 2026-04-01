cflags{
	'-std=c99', '-Wall',
	'-D _GNU_SOURCE',
	[[-D 'RUNSTATEDIR="/run"']],
	'-I $srcdir/src/uapi/linux',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

exe('wg', [[
	src/(
		config.c
		curve25519.c
		encoding.c
		genkey.c
		ipc.c
		pubkey.c
		set.c
		setconf.c
		show.c
		showconf.c
		terminal.c
		wg.c
	)
]])
file('bin/wg', '755', '$outdir/wg')
man{'src/man/wg.8'}

fetch 'git'
