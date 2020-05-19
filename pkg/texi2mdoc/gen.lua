cflags{
        '-D __BEGIN_DECLS=',
        '-D __END_DECLS=',
        '-Wall',
}

sub('host.ninja', function()
	toolchain(config.host)
	cflags{'-D __BEGIN_DECLS=', '-D __END_DECLS='}
	set('outdir', '$outdir/host')
	exe('texi2mdoc', {'main.c', 'util.c'})
end)

file('bin/texi2mdoc', '755', exe('texi2mdoc', {'main.c', 'util.c'}))
man{'texi2mdoc.1'}

fetch 'curl'
