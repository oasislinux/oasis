cflags{
	'-std=c99', '-Wall', '-Wpedantic', '-Wno-error',
	'-D HAVE_CONFIG_H',
	'-I $srcdir/src',
	'-I $srcdir/src/libbluray',
	'-I $srcdir/jni',
	'-I $srcdir/jni/linux',
	'-I $srcdir/contrib/libudfread/src',
	'-I $outdir/include',
	'-I $dir',
	'-isystem $builddir/pkg/freetype/include',
}

pkg.hdrs = {
	copy('$outdir/include/libbluray', '$srcdir/src/libbluray', {'bluray.h', 'keys.h'}),
	copy('$outdir/include/libbluray', '$srcdir/src/util', {'log_control.h'}),
	copy('$outdir/include/libbluray', '$srcdir/src/libbluray/bdnav', {'meta_data.h'}),
	copy('$outdir/include/libbluray', '$srcdir/src/libbluray/decoders', {'overlay.h'}),
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/include/libbluray/bluray-version.h',
	'pkg/freetype/headers',
}

build('sed', '$outdir/include/libbluray/bluray-version.h', '$srcdir/src/libbluray/bluray-version.h.in', {
	expr={
		'-e s,@BLURAY_VERSION_MAJOR@,1,',
		'-e s,@BLURAY_VERSION_MINOR@,3,',
		'-e s,@BLURAY_VERSION_MICRO@,4,',
	},
})

lib('libbluray.a', [[
	src/file/file.c
	src/file/filesystem.c
	src/libbluray/bluray.c
	src/libbluray/register.c
	src/libbluray/bdnav/bdid_parse.c
	src/libbluray/bdnav/bdmv_parse.c
	src/libbluray/bdnav/clpi_parse.c
	src/libbluray/bdnav/extdata_parse.c
	src/libbluray/bdnav/index_parse.c
	src/libbluray/bdnav/meta_parse.c
	src/libbluray/bdnav/mpls_parse.c
	src/libbluray/bdnav/navigation.c
	src/libbluray/bdnav/sound_parse.c
	src/libbluray/bdnav/uo_mask.c
	src/libbluray/decoders/graphics_controller.c
	src/libbluray/decoders/graphics_processor.c
	src/libbluray/decoders/ig_decode.c
	src/libbluray/decoders/m2ts_demux.c
	src/libbluray/decoders/m2ts_filter.c
	src/libbluray/decoders/pg_decode.c
	src/libbluray/decoders/pes_buffer.c
	src/libbluray/decoders/rle.c
	src/libbluray/decoders/textst_decode.c
	src/libbluray/decoders/textst_render.c
	src/libbluray/disc/aacs.c
	src/libbluray/disc/bdplus.c
	src/libbluray/disc/dec.c
	src/libbluray/disc/disc.c
	src/libbluray/disc/properties.c
	src/libbluray/hdmv/hdmv_vm.c
	src/libbluray/hdmv/mobj_parse.c
	src/libbluray/hdmv/mobj_print.c
	src/util/array.c
	src/util/bits.c
	src/util/event_queue.c
	src/util/logging.c
	src/util/mutex.c
	src/util/refcnt.c
	src/util/strutl.c
	src/util/time.c

	src/libbluray/bdj/bdj.c
	src/libbluray/bdj/bdjo_parse.c
	src/libbluray/bdj/native/bdjo.c
	src/libbluray/bdj/native/java_awt_BDFontMetrics.c
	src/libbluray/bdj/native/java_awt_BDGraphics.c
	src/libbluray/bdj/native/org_videolan_Libbluray.c
	src/libbluray/bdj/native/org_videolan_Logger.c
	src/libbluray/bdj/native/register_native.c
	src/libbluray/bdj/native/util.c

	src/libbluray/disc/udf_fs.c
	contrib/libudfread/src/default_blockinput.c
	contrib/libudfread/src/ecma167.c
	contrib/libudfread/src/udfread.c

	src/file/dir_posix.c
	src/file/dirs_xdg.c
	src/file/dl_posix.c
	src/file/file_posix.c
	src/file/mount.c

	$builddir/pkg/freetype/libfreetype.a.d
]])

fetch 'curl'
