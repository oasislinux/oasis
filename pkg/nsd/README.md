# nsd
nsd is an authoritative name server.

## config.h
Generated with

	./configure \
		--prefix= \
		--sbindir=/bin \
		--with-zonesdir=/etc/nsd/zone \
		--with-pidfile=/run/nsd.pid \
		--without-ssl \
		--without-libevent \
		CPPFLAGS=-I/src/oasis/pkg/openbsd/include \
		LIBS=/src/oasis/out/pkg/openbsd/libbsd.a

`HAVE_SYSLOG_H` was changed to false since we handle logging from stdout with
perp and tinylog. `HAVE_B64_NTOP` and `HAVE_B64_PTON` were changed to false so
that `config.h` will declare their prototypes since they are used without
including `resolv.h`.
