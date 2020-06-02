cflags{
	'-Wno-deprecated-declarations',
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/include', {'pciaccess.h'})

lib('libpciaccess.a', [[src/(
	common_bridge.c
	common_iterator.c
	common_init.c
	common_interface.c
	common_io.c
	common_capability.c
	common_device_name.c
	common_map.c
	common_vgaarb.c
	linux_sysfs.c linux_devmem.c
)]])

fetch 'git'
