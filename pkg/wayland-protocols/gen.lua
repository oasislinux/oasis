cflags{'-I $builddir/pkg/wayland/include'}

waylandproto('stable/presentation-time/presentation-time.xml', {
	client='include/presentation-time-client-protocol.h',
	code='presentation-time-protocol.c',
})

waylandproto('stable/xdg-shell/xdg-shell.xml', {
	client='include/xdg-shell-client-protocol.h',
	server='include/xdg-shell-server-protocol.h',
	code='xdg-shell-protocol.c',
})

waylandproto('unstable/idle-inhibit/idle-inhibit-unstable-v1.xml', {
	client='include/idle-inhibit-unstable-v1-client-protocol.h',
	server='include/idle-inhibit-unstable-v1-server-protocol.h',
	code='idle-inhibit-unstable-v1-protocol.c'
})

waylandproto('unstable/linux-dmabuf/linux-dmabuf-unstable-v1.xml', {
	client='include/linux-dmabuf-unstable-v1-client-protocol.h',
	server='include/linux-dmabuf-unstable-v1-server-protocol.h',
	code='linux-dmabuf-unstable-v1-protocol.c',
})

waylandproto('unstable/xdg-decoration/xdg-decoration-unstable-v1.xml', {
	client='include/xdg-decoration-unstable-v1-client-protocol.h',
	code='xdg-decoration-unstable-v1-protocol.c',
})

pkg.hdrs = {
	'$outdir/include/presentation-time-client-protocol.h',
	'$outdir/include/xdg-shell-client-protocol.h',
	'$outdir/include/xdg-shell-server-protocol.h',
	'$outdir/include/idle-inhibit-unstable-v1-client-protocol.h',
	'$outdir/include/idle-inhibit-unstable-v1-server-protocol.h',
	'$outdir/include/linux-dmabuf-unstable-v1-client-protocol.h',
	'$outdir/include/linux-dmabuf-unstable-v1-server-protocol.h',
	'$outdir/include/xdg-decoration-unstable-v1-client-protocol.h',
}

fetch 'git'
