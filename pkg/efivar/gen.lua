cflags{
	'-Wall', '-Wextra',
	'-D _GNU_SOURCE',
	'-D LIBEFIVAR_VERSION=39',
	'-include $dir/compat.h',
	'-I $outdir/include',
	'-I $srcdir/src',
	'-I $srcdir/src/include',
	'-isystem $builddir/pkg/linux-headers/include',
}

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{
		'-std=c99',
		'-D _GNU_SOURCE',
		'-D EFIVAR_BUILD_ENVIRONMENT',
		'-I $srcdir/src/include',
	}
	build('cc', '$outdir/host-util.c.o', '$srcdir/src/util.c')
	exe('makeguids', {'src/makeguids.c', 'host-util.c.o'})
end)

rule('makeguids', '$outdir/makeguids $in $out')
build('makeguids', {
	'$outdir/guid-symbols.c',
	'$outdir/include/efivar/efivar-guids.h',
}, {'$srcdir/src/guids.txt', '|', '$outdir/makeguids'})

pkg.hdrs = {
	copy('$outdir/include/efivar', '$srcdir/src/include/efivar', {
		'efiboot.h',
		'efiboot-creator.h',
		'efiboot-loadopt.h',
		'efivar.h',
		'efivar-dp.h',
		'efivar-time.h',
		'efivar-types.h',
	}),
	'$outdir/include/efivar/efivar-guids.h',
}
pkg.deps = {
	'$outdir/include/efivar/efivar-guids.h',
	'pkg/linux-headers/headers',
}

cc('src/crc32.c')

lib('libefiboot.a', [[
	src/(
		crc32.c.o creator.c disk.c gpt.c loadopt.c path-helpers.c linux.c
		linux-(acpi acpi-root ata emmc i2o md nvme pci pci-root pmem sas sata scsi soc-root virtblk virtual-root).c
	)
]])
lib('libefivar.a', [[
	src/(
		crc32.c.o dp.c dp-acpi.c dp-hw.c dp-media.c dp-message.c
		efivarfs.c error.c export.c guid.c
		lib.c vars.c time.c
	)
	$outdir/guid-symbols.c
]])

fetch 'git'
