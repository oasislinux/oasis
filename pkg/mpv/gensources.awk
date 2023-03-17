# usage: awk -f gensources.awk src/wscript_build.py >sources.txt

BEGIN {
	FS = "\""
	external["generated/wayland/idle-inhibit-unstable-v1.c"] = "$builddir/pkg/wayland-protocols/idle-inhibit-unstable-v1-protocol.c.o"
	external["generated/wayland/linux-dmabuf-unstable-v1.c"] = "$builddir/pkg/wayland-protocols/linux-dmabuf-unstable-v1-protocol.c.o"
	external["generated/wayland/presentation-time.c"] = "$builddir/pkg/wayland-protocols/presentation-time-protocol.c.o"
	external["generated/wayland/viewporter.c"] = "$builddir/pkg/wayland-protocols/viewporter-protocol.c.o"
	external["generated/wayland/xdg-decoration-unstable-v1.c"] = "$builddir/pkg/wayland-protocols/xdg-decoration-unstable-v1-protocol.c.o"
	external["generated/wayland/xdg-shell.c"] = "$builddir/pkg/wayland-protocols/xdg-shell-protocol.c.o"
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
