cflags{
	'-std=c99', '-Wall',
	[[-D 'EFIBOOTMGR_VERSION="17"']],
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

exe('efibootmgr', [[
	src/(efibootmgr.c efi.c unparse_path.c)
	$builddir/pkg/efivar/(libefiboot.a libefivar.a)
]])
file('bin/efibootmgr', '755', '$outdir/efibootmgr')
man{'src/efibootmgr.8'}

fetch 'git'
