cflags{
	'-D HAVE_CONFIG_H',
	'-I $outdir',
	'-I $srcdir',
	'-I $srcdir/include',
	'-I $srcdir/x86',
	'-I $srcdir/asm',
	'-I $srcdir/disasm',
	'-I $srcdir/output',
}

build('cat', '$outdir/config/config.h', {
	'$builddir/probe/HAVE___BUILTIN_CHOOSE_EXPR',
	'$builddir/probe/HAVE___BUILTIN_CLZ',
	'$dir/config.h',
})

pkg.deps = {'$outdir/config/config.h'}

lib('libnasm.a', [[
	stdlib/(snprintf.c vsnprintf.c strlcpy.c strnlen.c strrchrnul.c)
	nasmlib/(
		ver.c
		alloc.c asprintf.c errfile.c
		crc32.c crc64.c md5c.c
		string.c nctype.c
		file.c mmap.c ilog2.c
		realpath.c path.c
		filename.c rlimit.c
		zerobuf.c readnum.c bsi.c
		rbtree.c hashtbl.c
		raa.c saa.c
		strlist.c
		perfhash.c badenum.c
	)
	common/common.c
	x86/(
		insnsa.c insnsb.c insnsd.c insnsn.c
		regs.c regvals.c regflags.c regdis.c
		disp8.c iflag.c
	)
	asm/(
		error.c warnings.c
		floats.c
		directiv.c directbl.c
		pragma.c
		assemble.c labels.c parser.c
		preproc.c quote.c pptok.c
		listing.c eval.c exprlib.c exprdump.c
		stdscan.c
		strfunc.c tokhash.c
		segalloc.c
		rdstrnum.c
		srcfile.c
	)
	macros/macros.c
	output/(
		outform.c outlib.c legacy.c
		nulldbg.c nullout.c
		outbin.c outaout.c outcoff.c
		outelf.c
		outobj.c outas86.c
		outdbg.c outieee.c outmacho.c
		codeview.c
	)
	disasm/(disasm.c sync.c)
]])

exe('nasm', {'asm/nasm.c', 'libnasm.a'})
file('bin/nasm', '755', '$outdir/nasm')
man{'nasm.1'}

fetch 'curl'
