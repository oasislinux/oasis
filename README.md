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
* [curl](https://curl.haxx.se/)
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

Several other projects can be built in the `devel`, `extra`, and `desktop`
directories.

# Prerequisites

To build it, you need a POSIX system with following tools:

* C toolchain for both host and target system
	- target toolchain must support [`#include_next`](https://gcc.gnu.org/onlinedocs/cpp/Wrapper-Headers.html)
* git
* gzip (or compatible tool)
* ninja
* rc (plan9-compatible)
* zic

On a stock Ubuntu install, you'll need to install a few packages.

	sudo apt install 9base ninja-build curl git pax bison libc6-i386
	PATH=$PATH:/usr/lib/plan9/bin

You'll also need a toolchain targeting musl libc. The stali toolchain is
convenient and works nicely.

	git clone http://git.sta.li/toolchain
	PATH=$PATH:$PWD/toolchain/

You should make sure that your git config has a set user and email (for applying
patches).

	git config --global user.name $MYNAME
	git config --global user.email $MYEMAIL

# Installation

These instructions use some references to environment variables. You are meant to replace those with appropriate values for your system.

* `DRIVE`: Your boot disk device.
* `ROOTPART`: Your / partition device.
* `BOOTPART`: Your /boot partition device.
* `TIMEZONE`: Your timezone.

First, prepare a root directory for oasis. We'll call it `$ROOT`. You should
mount any sub-filesystems you want at this time (for example, `/boot`).

	cd $ROOT
	git clone https://github.com/michaelforney/oasis src/oasis
	cd src/oasis

Now, fetch and extract the sources for the various packages.

	rc ./fetch.rc -a

Build oasis.

	rc ./setup.rc
	ninja

Prepare root repository.

	cd $ROOT
	git init --template src/oasis/out/template
	git remote add local src/oasis/out/root.git
	git fetch local
	git checkout master

Prepare your `/etc` repository.

	git clone --template src/oasis/out/template https://github.com/michaelforney/oasis-etc etc

Set up your system configuration.

	cd etc
	ln -s ../share/zoneinfo/$TIMEZONE localtime
	{ echo "/dev/$ROOTPART / ext4 rw,relatime 0 1"
	  echo "/dev/$BOOTPART /boot ext2 rw,relatime,noauto 0 0" } >>fstab

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

## Bootloader

Feel free to install any bootloader you want. `syslinux` is easy and convenient. For a BIOS system:

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

## Kernel

Build/obtain a kernel. By convention, install it at `/boot/linux`.
