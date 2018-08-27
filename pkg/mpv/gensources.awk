# usage: awk -f gensources.awk src/wscript_build.py >sources.txt

BEGIN {
	FS = "\""
	external["video/out/wayland/xdg-shell.c"] = "$builddir/pkg/wayland-protocols/xdg-shell-protocol.c.o"
	external["video/out/wayland/idle-inhibit-v1.c"] = "$builddir/pkg/wayland-protocols/idle-inhibit-v1-protocol.c.o"
	external["video/out/wayland/srv-decor.c"] = "video/out/wayland/srv-decor.c.o"
}

/sources = \[/ { insources = 1 }
insources && /\]/ { insources = 0 }

insources && / +\(.*\),$/ {
	src = $2
	if (src in external)
		src = external[src]
	if (NF == 3)
		print src
	else if (NF == 5)
		print src, $4
}
