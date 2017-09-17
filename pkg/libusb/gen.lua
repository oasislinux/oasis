cflags{
	'-I include',
	'-I $dir',
	'-I $srcdir/libusb',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/libusb', {'libusb.h'})

lib('libusb-1.0.a', [[libusb/(
	core.c descriptor.c hotplug.c io.c strerror.c sync.c
	os/(poll_posix.c threads_posix.c linux_usbfs.c linux_netlink.c)
)]])

fetch 'git'
