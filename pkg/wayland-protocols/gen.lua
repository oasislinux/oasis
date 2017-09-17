cflags{'-I $builddir/pkg/wayland/include'}

waylandproto('unstable/xdg-shell/xdg-shell-unstable-v5.xml',
	'include/xdg-shell-unstable-v5-client-protocol.h',
	'include/xdg-shell-unstable-v5-server-protocol.h',
	'xdg-shell-unstable-v5-protocol.c'
)

pkg.hdrs = {
	'$outdir/include/xdg-shell-unstable-v5-client-protocol.h',
	'$outdir/include/xdg-shell-unstable-v5-server-protocol.h',
}

fetch 'git'
