cc('src/guids.S', {'$outdir/guids.bin', '$outdir/names.bin'}, {
	cflags='$cflags -I $outdir',
})

cflags{
	'-Wall', '-Wextra',
	'-D _GNU_SOURCE',
	'-include $dir/compat.h',
	'-I $outdir/include',
	'-I $srcdir/src/include',
}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{
		'-std=c99',
		'-D _GNU_SOURCE',
		'-D EFIVAR_BUILD_ENVIRONMENT',
		'-I $srcdir/src/include',
	}
	build('cc', '$outdir/host-guid.c.o', '$srcdir/src/guid.c')
	exe('makeguids', {'src/makeguids.c', 'host-guid.c.o'}, nil, {
		ldlibs='-ldl',
		-- src/generics.h defines some static inline functions that refer to undefined symbols
		ldflags='$ldflags -Wl,--unresolved-symbols=ignore-in-object-files',
	})
end)

rule('makeguids', '$outdir/makeguids $in $out')
build('makeguids', {
	'$outdir/guids.bin',
	'$outdir/names.bin',
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
	}),
	'$outdir/include/efivar/efivar-guids.h',
}
pkg.deps = {'$outdir/include/efivar/efivar-guids.h'}

lib('libefiboot.a', [[
	src/(
		crc32.c creator.c disk.c gpt.c loadopt.c path-helpers.c linux.c
		linux-(ata i2o nvme pci pmem sas sata scsi virtblk).c
	)
]])
lib('libefivar.a', [[
	src/(
		dp.c dp-acpi.c dp-hw.c dp-media.c dp-message.c
		efivarfs.c error.c export.c guid.c guids.S.o
		lib.c vars.c
	)
	$outdir/guid-symbols.c
]])

fetch 'git'
