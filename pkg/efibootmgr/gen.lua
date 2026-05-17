cflags{
	'-std=c99', '-Wall',
	[[-D 'EFIBOOTMGR_VERSION="18"']],
	[[-D 'DEFAULT_LOADER="/linux"']],
	'-I $srcdir/src/include',
	'-isystem $builddir/pkg/efivar/include',
	'-isystem $builddir/pkg/efivar/include/efivar',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {
	'pkg/efivar/headers',
	'pkg/linux-headers/headers',
}

build('sed', '$outdir/efibootmgr.8', '$srcdir/src/efibootmgr.8.in', {
	expr='s,@@DEFAULT_LOADER@@,/linux,g',
})

exe('efibootmgr', [[
	src/(efibootmgr.c efi.c parse_loader_data.c)
	$builddir/pkg/efivar/(libefiboot.a libefivar.a)
]])
file('bin/efibootmgr', '755', '$outdir/efibootmgr')
man{'$outdir/efibootmgr.8'}

fetch 'git'
