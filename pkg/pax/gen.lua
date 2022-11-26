cflags{'-std=c99', '-Wall', '-Wpedantic'}

exe('pax', {'pax.c'})

sub('host.ninja', function()
	set('outdir', '$outdir/host')
	toolchain(config.host)
	exe('pax', {'pax.c'})
end)
