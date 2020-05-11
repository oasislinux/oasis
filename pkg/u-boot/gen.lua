cflags{
	'-D USE_HOSTCC',
	'-I $dir',
	'-I $srcdir/tools',
	'-I $builddir/pkg/linux-headers/include',
	'-idirafter $srcdir/include',
	'-include $srcdir/include/compiler.h',
}

pkg.deps = {
	'pkg/linux-headers/headers',
}

-- XXX: missing imximage.c and fdtdec_common.c, but seems to build without them
local objs = objects[[
	tools/(
		aisimage.c
		atmelimage.c
		default_image.c
		imagetool.c
		imx8image.c
		imx8mimage.c
		kwbimage.c
		lpc32xximage.c
		mxsimage.c
		omapimage.c
		os_support.c
		pblimage.c
		pbl_crc32.c
		vybridimage.c
		stm32image.c
		rkcommon.c
		rkimage.c
		rksd.c
		rkspi.c
		socfpgaimage.c
		ublimage.c
		zynqimage.c
		zynqmpimage.c
		zynqmpbif.c
		gpimage.c
		gpimage-common.c
		mtk_image.c
	)
	common/(
		bootm.c
		image.c
		hash.c
	)
	lib/(
		crc16.c
		crc32.c
		fdtdec.c
		md5.c
		rc4.c
		sha1.c
		sha256.c
	)
]]

exe('mkimage', {'tools/mkimage.c', objs})
file('bin/mkimage', '755', '$outdir/mkimage')

exe('dumpimage', {'tools/dumpimage.c', objs})
file('bin/dumpimage', '755', '$outdir/dumpimage')

fetch 'curl'
