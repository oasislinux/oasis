oasis is a small linux system

# Principles

* Binaries should be linked statically. This is made possible by lightweight
  system components like musl libc, and a central source repository to keep
  track of system-wide dependencies.
* Software components should be built in a generic way that allows the user to
  easily customize and/or modify as needed.
* Sources can be referenced through a URL or git submodule, but not included
  directly in the oasis repository. This way, users only need to download the
  sources they are interested in.

# Components

oasis uses software from a lot of different projects. The core system is built
up from the following:

* [musl](http://musl-libc.org/) (libc)
* [suckless](http://core.suckless.org/)
	- sbase
	- ubase
	- sinit
	- sdhcp
* [openbsd](http://openbsd.org/)
	- pax, yacc, fmt, diff, patch
* [plan9port](http://swtch.com/plan9port/)
	- rc, sam
* [awk](http://github.com/onetrueawk/awk/)
* [bzip2](http://bzip.org/)
* [bc](https://www.gnu.org/software/bc/)
* [curl](https://curl.haxx.se/)
* [e2fsprogs](http://e2fsprogs.sourceforge.net/)
* [git](https://git-scm.com/)
* [iproute2](http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2)
* [kbd](http://kbd-project.org/)
* [libressl](http://www.libressl.org/)
* [mdocml](http://mdocml.bsd.lv/)
* [ninja](https://ninja-build.org/) (build tool)
* [openssh](http://www.openssh.com/)
* [perp](http://b0llix.net/perp/) (process supervisor)
* [pigz](http://zlib.net/pigz/) (gzip)
* [tz](https://www.iana.org/time-zones)
* util-linux
* [xz](http://tukaani.org/xz/)
