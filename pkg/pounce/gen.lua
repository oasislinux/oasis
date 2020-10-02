cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic',
	'-D _GNU_SOURCE',
	'-isystem $builddir/pkg/libtls-bearssl/include',
}

pkg.deps = {'pkg/libtls-bearssl/headers'}

exe('pounce', {
	'bounce.c',
	'cert.c',
	'client.c',
	'config.c',
	'local.c',
	'ring.c',
	'server.c',
	'state.c',
	'xdg.c',
	'$builddir/pkg/libtls-bearssl/libtls.a.d',
})
file('bin/pounce', '755', '$outdir/pounce')
man{'pounce.1'}

exe('calico', {
	'dispatch.c',
})
file('bin/calico', '755', '$outdir/calico')
man{'calico.1'}

fetch 'git'
