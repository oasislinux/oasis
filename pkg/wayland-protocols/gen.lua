cflags{'-I $builddir/pkg/wayland/include'}

waylandproto('stable/xdg-shell/xdg-shell.xml', {
	client='include/xdg-shell-client-protocol.h',
	server='include/xdg-shell-server-protocol.h',
	code='xdg-shell-protocol.c',
})

waylandproto('unstable/idle-inhibit/idle-inhibit-unstable-v1.xml', {
	client='include/idle-inhibit-unstable-v1-client-protocol.h',
	server='include/idle-inhibit-unstable-v1-server-protocol.h',
	code='idle-inhibit-v1-protocol.c'
})

pkg.hdrs = {
	'$outdir/include/xdg-shell-client-protocol.h',
	'$outdir/include/xdg-shell-server-protocol.h',
	'$outdir/include/idle-inhibit-unstable-v1-client-protocol.h',
	'$outdir/include/idle-inhibit-unstable-v1-server-protocol.h',
}

fetch 'git'
