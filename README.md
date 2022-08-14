# oasis

[![builds.sr.ht status](https://builds.sr.ht/~mcf/oasis/commits/.build.yml.svg)](https://builds.sr.ht/~mcf/oasis/commits/.build.yml)

oasis is a small linux system.

It is probably quite a bit different from other Linux-based operating
systems you might be familiar with, and is closer to to a BSD.

There are many features that distinguish it from other operating
systems:

* Completely **statically linked**.

All software in the base system is linked statically, including the
display server ([velox]) and web browser ([netsurf]). Compared to
dynamic linking, this is a simpler mechanism which eliminates
problems with upgrading libraries, and results in completely
self-contained binaries that can easily be copied to other systems.

[velox]: https://github.com/michaelforney/velox
[netsurf]: https://www.netsurf-browser.org

* **Fast builds** that are **100% reproducible**.

All packages are built with [samurai], using build manifests generated
by [Lua scripts]. This involves considerable up-front packaging
cost, but minimal maintenance cost, and offers numerous advantages,
including near optimal build times, predictable and reproducible
builds, reduced build-time dependencies, and incremental builds
even across package boundaries.

[samurai]: https://github.com/michaelforney/samurai
[Lua scripts]: https://github.com/oasislinux/oasis/blob/master/pkg/nasm/gen.lua

* **Minimal bootstrap dependencies**.

Any POSIX system with git, lua, curl, a sha256 utility, standard
compression utilities, and an `x86_64-linux-musl` cross compiler
can be used to bootstrap oasis. This makes it trivial to cross-compile,
even from non-Linux systems such as macOS or OpenBSD.

* **BearSSL** is the system TLS and crypto library.

BearSSL is incredibly small and well written, but is not widely
adopted. Through the use of libcurl, which now has native BearSSL
support, and [libtls-bearssl], an alternative implementation of
libtls based on BearSSL, oasis uses BearSSL throughout the system.
Only a [few optional packages] still require LibreSSL.

[libtls-bearssl]: https://sr.ht/~mcf/libtls-bearssl
[few optional packages]: https://github.com/oasislinux/oasis/issues/14

* **No package manager**.

Instead, you configure a set of [specifications] of what files from
which packages to include on your system, and the build system
writes the resulting filesystem tree into a git repository. This
can then be merged into `/`, or pulled from another machine.

[specifications]: https://github.com/oasislinux/oasis/blob/master/config.def.lua#L12-L15

* Integrates well with **OS-agnostic package systems**.

Although the aim is to provide a complete system, there is a lot
of free software out there, a lot of which does not match up well
to our goals. Rather than trying to build and maintain yet another
repository with thousands of packages, oasis works well with [pkgsrc]
and [nix]. This makes it easy to extend your system with software
you might need, while keeping the base system small and focused.

[pkgsrc]: https://github.com/oasislinux/oasis/wiki/pkgsrc
[nix]: https://nixos.org/nix

* Extremely **simple system configuration**.

A guiding principle is that the `/etc` directory should be simple
enough for system administrators to understand completely and
customize appropriately. The most complex file in the default
configuration is the system initialization script, [`/etc/rc.init`],
at only 16 lines.

[`/etc/rc.init`]: https://github.com/oasislinux/etc/blob/master/rc.init

* Mostly **ISO C conformant**.

A major goal of oasis is to build with [cproc], a C compiler which
is much stricter about the ISO C standard than gcc or clang, and
orders of magnitude smaller. Although this is a [work-in-progress
effort], all core packages, and most others, build successfully
with cproc.

[cproc]: https://sr.ht/~mcf/cproc
[work-in-progress effort]: https://github.com/oasislinux/oasis/issues/13

## Principles

* Software complexity should be measured by including all transitive
  dependencies.
* Executables should be linked statically.
* Software components should allow for easy customization and/or
  modification.
* Package sources should be referenced through a URL or git submodule,
  but not included directly.
* `/etc` should be simple enough to be understood in its entirety.
* Patches should be well organized, have good descriptions, and
  should always apply cleanly.

## Install

An install guide can be found on the [wiki].

However, keep in mind that oasis is an ambitious project, and there
is still a lot of work to do. Users should be comfortable building
their own kernel and tinkering with their system when things go wrong.
If you do run into trouble, I'm always happy to help you out.

[wiki]: https://github.com/michaelforney/oasis/wiki

## QEMU

If you'd like to give oasis a try without installing it yourself,
there is a QEMU image available [here][qemu-image].

Inside the archive are the root filesystem, a Linux kernel, and a
script to launch qemu. There is also `README.md` with some information
about how to use it. In short, use `./run` to launch in graphical
mode, and `./run -s` to launch in serial mode.

[qemu-image]: https://patchouli.sr.ht/builds.sr.ht/artifacts/~mcf/356456/5af47a3cf086151c/oasis-qemu.tar.xz

## Software

oasis uses smaller and simpler implementations of libraries and
tools whenever possible:

- musl instead of glibc
- sbase instead of coreutils
- ubase instead of util-linux
- pigz instead of gzip
- mandoc instead of man-db
- bearssl instead of openssl
- oksh instead of bash
- sdhcp instead of dhclient or dhcpcd
- vis instead of vim or emacs
- byacc instead of bison
- perp and sinit instead of sysvinit or systemd
- netsurf instead of chromium or firefox
- samurai instead of ninja
- velox instead of Xorg
- netbsd-curses instead of ncurses

These packages are grouped into logical [sets], and the full list
is available in the [pkg] directory.

If your favorite software is missing, keep in mind that you can
likely still install it via pkgsrc or nix.

[sets]: https://github.com/oasislinux/oasis/blob/master/sets.lua
[pkg]: https://github.com/oasislinux/oasis/blob/master/pkg

## Contact

There is a mailing list at
[~mcf/oasis@lists.sr.ht](mailto:~mcf/oasis@lists.sr.ht), and an IRC
channel at #oasis on [libera.chat](ircs://irc.libera.chat:6697).
Feel free to use them for questions, patches, or general discussion.
