cflags{
	[[-D 'EFIBOOTMGR_VERSION="16"']],
	[[-D 'DEFAULT_LOADER="/linux"']],
	'-I $srcdir/src/include',
	'-I $builddir/pkg/efivar/include',
	'-I $builddir/pkg/efivar/include/efivar',
}

exe('efibootmgr', [[
	src/(efibootmgr.c efi.c unparse_path.c)
	$builddir/pkg/efivar/(libefiboot.a libefivar.a)
]], {'pkg/efivar/headers'})
file('bin/efibootmgr', '755', '$outdir/efibootmgr')
man{'src/efibootmgr.8'}

fetch 'git'
