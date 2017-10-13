cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/include/drm',
}

lib('libdrm.a', {
	'xf86drm.c',
	'xf86drmHash.c',
	'xf86drmRandom.c',
	'xf86drmSL.c',
	'xf86drmMode.c',
})

if config.video_drivers and config.video_drivers['intel'] then
	cflags{'-D HAVE_INTEL=1', '-I pkg/libpciaccess/src/include'}
	pkg.deps = {'$builddir/pkg/libpciaccess/fetch.stamp'}
	lib('libdrm_intel.a', [[
		intel/(
			intel_bufmgr.c
			intel_bufmgr_fake.c
			intel_bufmgr_gem.c
			intel_decode.c
			mm.c
		)
		$builddir/pkg/libpciaccess/libpciaccess.a
	]])
end

if config.video_drivers and config.video_drivers['nouveau'] then
	cflags{'-D HAVE_NOUVEAU=1'}
	lib('libdrm_nouveau.a', [[
		nouveau/(
			nouveau.c
			pushbuf.c
			bufctx.c
			abi16.c
		)
	]])
end

fetch 'git'
