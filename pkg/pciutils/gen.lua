cflags{
	'-Wall', '-Wpedantic', '-Wno-parentheses',
	'-I $dir',
}

lib('libpci.a', [[
	lib/(
		init.c
		access.c
		generic.c
		dump.c
		names.c
		filter.c
		names-hash.c
		names-parse.c
		names-net.c
		names-cache.c
		names-hwdb.c
		params.c
		caps.c
		sysfs.c
	)
]])

cc('common.c')

exe('lspci', {
	'lspci.c',
	'ls-vpd.c',
	'ls-caps.c',
	'ls-caps-vendor.c',
	'ls-ecaps.c',
	'ls-kernel.c',
	'ls-tree.c',
	'ls-map.c',
	'common.c.o',
	'libpci.a',
})
file('bin/lspci', '755', '$outdir/lspci')
man({'$srcdir/lspci.man'}, '8')

exe('setpci', {
	'setpci.c',
	'common.c.o',
	'libpci.a',
})
file('bin/setpci', '755', '$outdir/setpci')
man({'$srcdir/setpci.man'}, '8')

file('share/pci.ids', '644', '$srcdir/pci.ids')
man({'$srcdir/pci.ids.man'}, '5')

fetch 'git'
