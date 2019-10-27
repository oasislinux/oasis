# oasis

[![Build Status](https://travis-ci.org/michaelforney/oasis.svg?branch=master)](https://travis-ci.org/michaelforney/oasis)

oasis is a small linux system

It is suitable for a range of uses including server and desktop. oasis provides
a solution for many common tasks:

* Display server (velox, wayland-based)
* Terminal (st)
* Program launcher (dmenu)
* Web browser (netsurf with custom frontend)
* Document viewer (mupdf)
* Media player (mpv)
* HTTP server (nginx)
* DNS server (nsd)
* BitTorrent client (transmission)

The entire system can be compiled in minutes, and uses up up only a couple
hundred megabytes of disk space (despite being statically linked). It is
entirely C-based, and most packages make limited use of GNU C extensions.
Additionally all packages are built in a way that ensures the binaries are 100%
reproducible.

Updating your system is as simple as

	git -C /src/oasis pull
	samu -C /src/oasis commit
	doas git -C / merge

For more information, see the [wiki].

## Principles

* Binaries should be linked statically. This is made possible by lightweight
  system components like musl libc, and a central source repository to keep
  track of system-wide dependencies.
* Software components should be built in a way that allows the user to easily
  customize and/or modify as needed.
* Sources can be referenced through a URL or git submodule, but not included
  directly in the oasis repository. This way, users only need to download the
  sources they are interested in.
* `/etc` directory should be simple enough for system administrators to
  understand in its entirety and customize appropriately.

## Components

oasis uses software from a lot of different [packages]. The core system is built
up from the following:

* [musl](http://musl-libc.org/) (libc)
* [suckless](http://core.suckless.org/)
	- sbase, ubase, sinit, sdhcp
* [openbsd](http://openbsd.org/)
	- pax, fmt, diff, patch, doas
* [plan9port](http://swtch.com/plan9port/)
	- rc, sam
* [awk](http://github.com/onetrueawk/awk/)
* [byacc](https://invisible-island.net/byacc/byacc.html)
* [bzip2](http://bzip.org/)
* [bc](https://github.com/gavinhoward/bc)
* [curl](https://curl.haxx.se/)
* [e2fsprogs](http://e2fsprogs.sourceforge.net/)
* [git](https://git-scm.com/)
* [iproute2](http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2)
* [kbd](http://kbd-project.org/)
* [libressl](http://www.libressl.org/)
* [lua](https://www.lua.org/)
* [mandoc](http://mandoc.bsd.lv/)
* [samurai](https://github.com/michaelforney/samurai) (ninja-compatible build tool)
* [openntpd](http://www.openntpd.org/)
* [openssh](http://www.openssh.com/)
* [perp](http://b0llix.net/perp/) (process supervisor)
* [pigz](http://zlib.net/pigz/) (gzip)
* [tz](https://www.iana.org/time-zones)
* util-linux (fdisk, losetup)
* [xz](http://tukaani.org/xz/)

[wiki]: https://github.com/michaelforney/oasis/wiki
[packages]: https://github.com/michaelforney/oasis/tree/master/pkg
