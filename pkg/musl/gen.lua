local arch = 'x86_64'
cflags{
	'-D _XOPEN_SOURCE=700',
	'-nostdinc',
	'-I $srcdir/arch/'..arch,
	'-I $srcdir/arch/generic',
	'-I $outdir',
	'-I $srcdir/src/include',
	'-I $srcdir/src/internal',
	'-I $srcdir/include',
	'-I $outdir/include',
}

build('sed', '$outdir/include/bits/alltypes.h', {
	'$srcdir/arch/'..arch..'/bits/alltypes.h.in',
	'$srcdir/include/alltypes.h.in',
	'|', '$srcdir/tools/mkalltypes.sed',
}, {expr='-f $srcdir/tools/mkalltypes.sed'})

build('sed', '$outdir/include/bits/syscall.h', {'$srcdir/arch/'..arch..'/bits/syscall.h.in'}, {
	expr='-n -e ps,__NR_,SYS_,p',
})

build('awk', '$outdir/version.h', '$dir/ver', {expr=[['{printf "#define VERSION \"%s\"\n", $$1}']]})

pkg.deps = {
	'$outdir/include/bits/alltypes.h',
	'$outdir/include/bits/syscall.h',
	'$outdir/version.h',
}

local basefiles = load('base.lua')
local archfiles = load(arch..'.lua')

local srcmap, srcs = {}, {}
for src in iterstrings{basefiles.srcs, archfiles.srcs} do
	srcmap[src:match('(.*)%.'):gsub('/'..arch..'/', '/', 1)] = src
end
for _, src in pairs(srcmap) do
	table.insert(srcs, src)
end

lib('libc.a', srcs)
build('cc', '$outdir/crt1.o', '$srcdir/crt/crt1.c')
build('cc', '$outdir/rcrt1.o', '$srcdir/crt/rcrt1.c', {cflags='$cflags -fPIC'})

fetch 'git'
