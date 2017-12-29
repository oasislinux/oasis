# usage: awk -f gensources.awk src/wscript_build.py >sources.txt

BEGIN {
	FS = "\""
	ignore["osdep/terminal-dummy.c"] = 1
	ignore["input/ipc-dummy.c"] = 1
	ignore["osdep/subprocess-dummy.c"] = 1
	external["video/out/wayland/xdg-shell-v6.c"] = "$builddir/pkg/wayland-protocols/xdg-shell-unstable-v6-protocol.c.o"
	external["video/out/wayland/idle-inhibit-v1.c"] = "$builddir/pkg/wayland-protocols/idle-inhibit-v1-protocol.c.o"
	external["video/out/wayland/srv-decor.c"] = "video/out/wayland/srv-decor.c.o"
}

/ +\(.*\),$/ {
	src = $2
	if (src in ignore)
		next
	if (src in external)
		src = external[src]
	if (NF == 3)
		print src
	else if (NF == 5)
		print src, $4
}
