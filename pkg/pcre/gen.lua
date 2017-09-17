cflags{
	'-D HAVE_CONFIG_H',
	'-I include',
	'-I $dir',
	'-I $srcdir',
	'-I $outdir/include',
}

build('sed', '$outdir/include/pcre.h', '$srcdir/pcre.h.in', {
	expr={
		'-e s,@PCRE_MAJOR@,8,',
		'-e s,@PCRE_MINOR@,41,',
		'-e s,@PCRE_PRERELEASE@,,',
		'-e s,@PCRE_DATE@,2017-07-05,',
	},
})
pkg.hdrs = {'$outdir/include/pcre.h'}

build('copy', '$outdir/pcre_chartables.c', '$srcdir/pcre_chartables.c.dist')
lib('libpcre.a', {
	'pcre_byte_order.c',
	'pcre_compile.c',
	'pcre_config.c',
	'pcre_dfa_exec.c',
	'pcre_exec.c',
	'pcre_fullinfo.c',
	'pcre_get.c',
	'pcre_globals.c',
	'pcre_jit_compile.c',
	'pcre_maketables.c',
	'pcre_newline.c',
	'pcre_ord2utf8.c',
	'pcre_refcount.c',
	'pcre_string_utils.c',
	'pcre_study.c',
	'pcre_tables.c',
	'pcre_ucd.c',
	'pcre_valid_utf8.c',
	'pcre_version.c',
	'pcre_xclass.c',
	'$outdir/pcre_chartables.c',
}, {'$dir/headers'})

fetch 'curl'
