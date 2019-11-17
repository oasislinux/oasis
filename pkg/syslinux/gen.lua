cflags{
	'-I $dir',
	'-I $outdir',
	'-I $srcdir/libinstaller',

	-- NOTE: we should only have to include $srcdir/libinstaller, but
	-- BSD pax/tar transforms symlink targets as well as filenames,
	-- trashing the libinstaller/advconst.h symlink.
	'-I $srcdir/com32/include/syslinux',
}

build('awk', '$outdir/version.h', {'$srcdir/version', '|', '$dir/version.awk'}, {
	expr=[[-f $dir/version.awk -v fmt='#define %s %s']],
})

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'-std=c99', '-pedantic', '-Wall', '-Wextra'}
	set('srcdir', '$dir')
	exe('bin2c', {'bin2c.c'})
end)

rule('bin2c', '$outdir/bin2c $args <$in >$out')
function bin2c(bin, args)
	local name = args[1]
	build('bin2c', '$outdir/'..name..'.c', {
		'$srcdir/'..bin, '|', '$outdir/bin2c',
	}, {args=args})
end

bin2c('bios/core/ldlinux.bss', {'syslinux_bootsect'})
bin2c('bios/core/ldlinux.sys', {'syslinux_ldlinux', '512'})
bin2c('bios/com32/elflink/ldlinux/ldlinux.c32', {'syslinux_ldlinuxc32'})

exe('bin/extlinux', [[
	extlinux/(main.c mountinfo.c)
	libinstaller/(
		syslxmod.c
		syslxopt.c
		syslxcom.c
		setadv.c
		advio.c
	)
	$outdir/syslinux_(bootsect ldlinux ldlinuxc32).c
]], {'$outdir/version.h'})
file('bin/extlinux', '755', '$outdir/bin/extlinux')

file('lib/syslinux/bios/mbr.bin', '644', '$srcdir/bios/mbr/mbr.bin')

fetch 'curl'
