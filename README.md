oasis is a small linux system

# Components

oasis uses software from a lot of different projects. The core system is built
up from the following:

* [musl](http://musl-libc.org/) (libc)
* [suckless](http://core.suckless.org/)
	- sbase
	- ubase
	- sinit
* [openbsd](http://openbsd.org/)
	- pax, yacc, fmt, diff, patch
* [plan9port](http://swtch.com/plan9port/)
	- rc, sam
* [awk](http://github.com/onetrueawk/awk/)
* [bzip2](http://bzip.org/)
* [bc](https://www.gnu.org/software/bc/)
* [curl](https://curl.haxx.se/)
* [e2fsprogs](http://e2fsprogs.sourceforge.net/)
* [file](https://www.darwinsys.com/file/)
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
* [xz](http://tukaani.org/xz/)

Several other projects can be built in the `desktop`, `devel`, `extra`, and
`media` directories.

# Principles

* Binaries should be linked statically. This is made possible by lightweight
  system components like musl libc, and a central source repository to keep
  track of system-wide dependencies.
* Software components should be built in a generic way that allows the user to
  easily customize and/or modify as needed.
* Sources can be referenced through a URL or git submodule, but not included
  directly in the oasis repository. This way, users only need to download the
  sources they are interested in.

# Prerequisites

To build it, you need a POSIX system with following tools:

* C toolchain for both host and target system
	- target toolchain must support [`#include_next`](https://gcc.gnu.org/onlinedocs/cpp/Wrapper-Headers.html)
* curl
* git
* gzip (or compatible tool)
* ninja
* rc (plan9-compatible)
* zic

On a Debian-based system, you'll need to install a few packages.

	sudo apt install 9base bison curl git ninja-build pax
	PATH=$PATH:/usr/lib/plan9/bin

You'll also need a toolchain targeting musl libc. I recommend [musl-cross-make]
if you want to build your own. If not, feel free to use my pre-built toolchain.

	git clone https://github.com/michaelforney/oasis-toolchain
	PATH=$PATH:$PWD/oasis-toolchain/bin

You should make sure that your git config has a set user and email (for applying
patches).

	git config --global user.name $MYNAME
	git config --global user.email $MYEMAIL

[musl-cross-make]: https://github.com/richfelker/musl-cross-make

# Installation

These instructions use some references to environment variables. You are meant
to replace those with appropriate values for your system.

* `EDITOR`: Your text editor.
* `DRIVE`: Your target disk device.
* `ROOTPART`: Your / partition device.
* `BOOTPART`: Your /boot partition device.
* `TIMEZONE`: Your timezone.

First, prepare a root directory for oasis. We'll call it `$ROOT`. You should
mount any sub-filesystems you want at this time (for example, `/boot`).

	cd $ROOT
	git clone -c 'core.sharedRepository=group' https://github.com/michaelforney/oasis src/oasis
	cd src/oasis

Next, configure `config.rc` to your liking.

	$EDITOR config.rc

Generate the ninja build files.

	rc ./setup.rc

If the version of `file` on your host system is less than 5.29, you'll need to
obtain a newer version. If you are not cross-compiling, you can just use the one
from oasis.

	ninja out/core/file/file
	mkdir $HOME/bin
	cp out/core/file/file $HOME/bin
	PATH=$HOME/bin:$PATH

Build oasis.

	ninja commit

Prepare root repository.

	cd $ROOT
	git init --template src/oasis/template
	git remote add local src/oasis/out/root.git
	git fetch local
	git checkout master

You may want to include a toolchain.

	git remote add toolchain https://github.com/michaelforney/oasis-toolchain
	git fetch toolchain
	git merge -Xours --allow-unrelated-histories toolchain/master

Prepare your `/etc` repository.

	git clone --template src/oasis/template -c 'oasis.root=..' https://github.com/michaelforney/oasis-etc etc

Set up your system configuration.

	cd etc
	ln -s ../share/zoneinfo/$TIMEZONE localtime
	cat >>fstab <<EOF
	/dev/$ROOTPART / ext4 rw,relatime 0 1
	/dev/$BOOTPART /boot ext2 rw,relatime,noauto 0 0
	EOF

Prepare for `chroot`.

	cd $ROOT
	mount -o rbind /dev dev
	mount -o bind /sys sys
	mount -t proc none proc
	chroot . /bin/ksh

Set a root password.

	passwd

Exit the chroot.

	exit

## Kernel

Build/obtain a kernel. By convention, install it at `/boot/linux`.

## Bootloader

Feel free to install any bootloader you want.

### syslinux

syslinux is one option that is easy and convenient. You'll need a 32-bit libc in
order to run the pre-built binaries. On Debian-based systems, this is in
`libc6-i386`.

	sudo apt install libc6-i386

For a BIOS system:

	cd /tmp
	curl -O https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.03.tar.gz
	zcat syslinux-6.03.tar.gz | pax -r
	mkdir $ROOT/boot/syslinux
	find syslinux-6.03/bios -name '*.c32' -exec cp {} $ROOT/boot/syslinux ';'
	syslinux-6.03/bios/extlinux/extlinux --install $ROOT/boot/syslinux
	dd if=syslinux-6.03/bios/mbr/mbr.bin of=/dev/$DRIVE bs=440
	cat >$ROOT/boot/syslinux/syslinux.cfg <<EOF
	PROMPT 1
	TIMEOUT 50
	DEFAULT oasis

	LABEL oasis
		LINUX ../linux
		APPEND root=/dev/$ROOTPART init=/bin/sinit ro
	EOF

### efibootmgr

If your system uses UEFI and you built your kernel with `CONFIG_EFI_STUB=y`, you
can use `efibootmgr` to set up a new boot entry.

	efibootmgr -c -d /dev/$DRIVE -p $BOOTPARTNUM -l /linux -L oasis "root=/dev/$BOOTPART init=/bin/sinit ro"

You might also want to enable `extra/efibootmgr` in your `config.rc`.
