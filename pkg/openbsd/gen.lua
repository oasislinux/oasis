cflags{
	[[-D 'DEF_WEAK(n)=']],
	'-I $dir/include',
	'-idirafter $srcdir/include',
	'-idirafter $srcdir/sys',
	'-idirafter $srcdir/lib/libutil',
}
local libs

if not config.tls or config.tls == 'libressl' then
	cflags{'-D USE_OPENSSL', '-I $builddir/pkg/libressl/include'}
	libs = {'$builddir/pkg/libressl/libcrypto-sha.a'}
elseif config.tls == 'bearssl' then
	cflags{'-D USE_BEARSSL', '-I pkg/bearssl/src/inc'}
	libs = {'$builddir/pkg/bearssl/libbearssl.a'}
else
	error('unknown config.tls: '..config.tls)
end

-- Link arc4random.c to '$outdir' so that it doesn't include the local
-- arc4random.h
build('copy', '$outdir/lib/libc/crypt/arc4random.c', '$srcdir/lib/libc/crypt/arc4random.c')
build('copy', '$outdir/lib/libc/crypt/arc4random.h', '$srcdir/lib/libcrypto/arc4random/arc4random_linux.h')
build('copy', '$outdir/lib/libc/crypt/chacha_private.h', '$srcdir/lib/libc/crypt/chacha_private.h')
cc('$outdir/lib/libc/crypt/arc4random.c', {
	'$outdir/lib/libc/crypt/arc4random.h',
	'$outdir/lib/libc/crypt/chacha_private.h',
})

lib('libbsd.a', {paths[[
	lib/libc/(
		crypt/(arc4random.c.o arc4random_uniform.c)
		gen/(fts.c getprogname.c pwcache.c readpassphrase.c setprogname.c unvis.c vis.c warnc.c vwarnc.c)
		net/base64.c
		stdlib/(freezero.c reallocarray.c recallocarray.c strtonum.c)
		string/(explicit_bzero.c strmode.c timingsafe_bcmp.c timingsafe_memcmp.c)
	)
	lib/libcrypto/arc4random/getentropy_linux.c
	lib/libutil/ohash.c
]], libs}, {'pkg/libressl/headers'})
file('lib/libbsd.a', '644', '$outdir/libbsd.a')

-- diff
exe('diff', 'usr.bin/diff/(diff.c diffdir.c diffreg.c xmalloc.c) libbsd.a')
file('bin/diff', '755', '$outdir/diff')
man{'usr.bin/diff/diff.1'}

-- doas
yacc('usr.bin/doas/parse', 'usr.bin/doas/parse.y')
cc('$outdir/usr.bin/doas/parse.tab.c', nil, {cflags='$cflags -I $srcdir/usr.bin/doas'})
cc('usr.bin/doas/doas.c', nil, {cflags='$cflags -D _GNU_SOURCE'})
exe('doas', 'usr.bin/doas/(doas.c.o env.c parse.tab.c.o persist.c) libbsd.a')
file('bin/doas', '6755', '$outdir/doas')
man{'usr.bin/doas/doas.1', 'usr.bin/doas/doas.conf.5'}

-- fmt
file('bin/fmt', '755', exe('fmt', {'usr.bin/fmt/fmt.c'}))
man{'usr.bin/fmt/fmt.1'}

-- m4
yacc('usr.bin/m4/parser', 'usr.bin/m4/parser.y')
cc('usr.bin/m4/tokenizer.c', {'$outdir/usr.bin/m4/parser.tab.h'}, {cflags='$cflags -I $outdir/usr.bin/m4'})
exe('m4', [[
	usr.bin/m4/(eval.c expr.c look.c main.c misc.c gnum4.c trace.c tokenizer.c.o)
	$outdir/usr.bin/m4/parser.tab.c
	libbsd.a
]])
file('bin/m4', '755', '$outdir/m4')
man{'usr.bin/m4/m4.1'}

-- nc
exe('nc', [[
	usr.bin/nc/(netcat.c atomicio.c socks.c)
	$builddir/pkg/libressl/libtls.a.d
]], {'pkg/libressl/headers'})
file('bin/nc', '755', '$outdir/nc')
man{'usr.bin/nc/nc.1'}

-- patch
exe('patch', 'usr.bin/patch/(patch.c pch.c inp.c util.c backupfile.c mkpath.c ed.c) libbsd.a')
file('bin/patch', '755', '$outdir/patch')
man{'usr.bin/patch/patch.1'}

-- pax
exe('pax', [[bin/pax/(
	ar_io.c ar_subs.c buf_subs.c cpio.c file_subs.c ftree.c
	gen_subs.c getoldopt.c options.c pat_rep.c pax.c sel_subs.c tables.c
	tar.c tty_subs.c
) libbsd.a]])
file('bin/pax', '755', '$outdir/pax')
sym('bin/tar', 'pax')
sym('bin/cpio', 'pax')
man{'bin/pax/pax.1', 'bin/pax/tar.1', 'bin/pax/cpio.1'}

-- yacc
exe('yacc', [[usr.bin/yacc/(
	closure.c error.c lalr.c lr0.c main.c mkpar.c output.c reader.c
	skeleton.c symtab.c verbose.c warshall.c
) libbsd.a]])
file('bin/yacc', '755', '$outdir/yacc')
man{'usr.bin/yacc/yacc.1'}

fetch 'local'
