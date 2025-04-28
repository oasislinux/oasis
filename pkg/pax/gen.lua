cflags{'-std=c99', '-Wall', '-Wpedantic'}

exe('pax', {'pax.c'})
file('bin/pax', '755', '$outdir/pax')

sub('host.ninja', function()
	set('outdir', '$outdir/host')
	toolchain(config.host)
	exe('pax', {'pax.c'})
end)

fetch 'git'
