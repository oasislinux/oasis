cflags{
	'-I $outdir',
	'-I $outdir/include',
}

build('cat', '$outdir/jconfigint.h', {
	'$builddir/probe/HAVE___BUILTIN_CTZL',
	'$dir/jconfigint.h',
})

pkg.deps = {
	'$dir/headers',
	'$outdir/jconfigint.h',
}

lib('libjpeg-turbo.a', [[
	jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c
	jcicc.c jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c
	jcphuff.c jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c jdatadst.c
	jdatasrc.c jdcoefct.c jdcolor.c jddctmgr.c jdhuff.c jdicc.c jdinput.c
	jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c
	jdtrans.c jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c
	jidctint.c jidctred.c jquant1.c jquant2.c jutils.c jmemmgr.c jmemnobs.c

	jaricom.c jcarith.c jdarith.c jsimd_none.c
]])

pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'jmorecfg.h', 'jpeglib.h'}),
	copy('$outdir/include', '$dir', {'jconfig.h'}),
}

fetch 'git'
