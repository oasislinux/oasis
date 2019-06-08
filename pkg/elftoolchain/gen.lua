cflags{
	'-Wall',
	'-I $dir',
	'-I $srcdir/common',
	'-I $srcdir/libelf',
	'-idirafter pkg/openbsd/src/sys',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/libelf', {'libelf.h', 'gelf.h'}),
	copy('$outdir/include', '$srcdir/common', {'elfdefinitions.h'}),
	install=true,
}

rule('m4', 'm4 -D SRCDIR=$srcdir/libelf $in >$out.tmp && mv $out.tmp $out')
build('m4', '$outdir/libelf_convert.c', {'$srcdir/libelf/libelf_convert.m4', '|', '$srcdir/libelf/elf_types.m4'})
build('m4', '$outdir/libelf_fsize.c', {'$srcdir/libelf/libelf_fsize.m4', '|', '$srcdir/libelf/elf_types.m4'})
build('m4', '$outdir/libelf_msize.c', {'$srcdir/libelf/libelf_msize.m4', '|', '$srcdir/libelf/elf_types.m4'})

lib('libelf.a', [[
	libelf/(
		elf.c
		elf_begin.c
		elf_cntl.c
		elf_end.c elf_errmsg.c elf_errno.c
		elf_data.c
		elf_fill.c
		elf_flag.c
		elf_getarhdr.c
		elf_getarsym.c
		elf_getbase.c
		elf_getident.c
		elf_hash.c
		elf_kind.c
		elf_memory.c
		elf_next.c
		elf_open.c
		elf_rand.c
		elf_rawfile.c
		elf_phnum.c
		elf_shnum.c
		elf_shstrndx.c
		elf_scn.c
		elf_strptr.c
		elf_update.c
		elf_version.c
		gelf_cap.c
		gelf_checksum.c
		gelf_dyn.c
		gelf_ehdr.c
		gelf_getclass.c
		gelf_fsize.c
		gelf_move.c
		gelf_phdr.c
		gelf_rel.c
		gelf_rela.c
		gelf_shdr.c
		gelf_sym.c
		gelf_syminfo.c
		gelf_symshndx.c
		gelf_xlate.c
		libelf_align.c
		libelf_allocate.c
		libelf_ar.c
		libelf_ar_util.c
		libelf_checksum.c
		libelf_data.c
		libelf_ehdr.c
		libelf_extended.c
		libelf_memory.c
		libelf_open.c
		libelf_phdr.c
		libelf_shdr.c
		libelf_xlate.c
	)
	$outdir/(libelf_convert.c libelf_fsize.c libelf_msize.c)
]])
file('lib/libelf.a', '644', '$outdir/libelf.a')

fetch 'curl'
