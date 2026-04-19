# binutils

## */config.h
Generated with

	./configure \
		--build=x86_64-unknown-linux-musl \
		--disable-gold \
		--disable-libctf \
		--disable-nls \
		--disable-plugins \
		--enable-compressed-debug-sections=gas \
		--enable-default-hash-style=gnu \
		--enable-deterministic-archives \
		--enable-new-dtags \
		--enable-separate-code \
		--enable-textrel-check \
		--enable-x86-used-note \
		--without-msgpack
	make configure-host

## aarch64 configuration

When configured with `--target=aarch64-linux-musl`,
``DEFAULT_X86_USED_NOTE`` is defined to 0, there is not need for ``CORE_HEADER`` in ``bfd/config.h``
since ``hosts/aarch64linux.h`` does not exist. Only target triplets are different.

`ldmain.c` expects a full triplet i.e `aarch64-unknown-linux-musl` to match the pattern: `aarch64-*-linux*`
