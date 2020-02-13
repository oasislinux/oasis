local arch = config.target.platform:match('[^-]*')
cflags{
	'-fPIC',
	'-nostdinc',
	'-D _XOPEN_SOURCE=700',
	'-I $srcdir/arch/'..arch,
	'-I $srcdir/arch/generic',
	'-I $outdir',
	'-I $srcdir/src/include',
	'-I $srcdir/src/internal',
	'-I $outdir/include',
}

local basefiles = load('base.lua')
local archfiles = load(arch..'.lua')

local bits = {}
for _, hdr in ipairs(archfiles.bits) do
	archfiles.bits[hdr] = true
end
for _, hdr in ipairs(basefiles.bits) do
	if not archfiles.bits[hdr] then
		table.insert(bits, hdr)
	end
end

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/include', basefiles.hdrs),
	copy('$outdir/include/bits', '$srcdir/arch/'..arch..'/bits', archfiles.bits),
	copy('$outdir/include/bits', '$srcdir/arch/generic/bits', bits),
	'$outdir/include/bits/alltypes.h',
	'$outdir/include/bits/syscall.h',
	install=true,
}
pkg.deps = {
	'$dir/headers',
	'$outdir/version.h',
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

local srcmap, srcs = {}, {}
for src in iterstrings{basefiles.srcs, archfiles.srcs} do
	srcmap[src:match('(.*)%.'):gsub('/'..arch..'/', '/', 1)] = src
end
for _, src in pairs(srcmap) do
	table.insert(srcs, src)
end
table.sort(srcs)

local objs = objects(srcs)
ar('libc.a', objs)
file('lib/libc.a', '644', '$outdir/libc.a')
exe('libc.so', {'ldso/dlstart.c', 'ldso/dynlink.c', objs}, nil, {
	ldflags='$ldflags -nostdlib -shared -Wl,-e,_dlstart',
	ldlibs='-lgcc',
})
file('lib/libc.so', '755', '$outdir/libc.so')
sym('lib/ld-musl-'..arch..'.so.1', 'libc.so')
sym('bin/ldd', '../lib/libc.so')

for _, lib in ipairs{'libm.a', 'librt.a', 'libpthread.a', 'libcrypt.a', 'libutil.a', 'libxnet.a', 'libresolv.a', 'libdl.a'} do
	ar(lib, {})
	file('lib/'..lib, '644', '$outdir/'..lib)
end

local startfiles = {'$outdir/libc.a'}
for _, obj in ipairs{'crt1.o', 'crti.o', 'crtn.o', 'rcrt1.o'} do
	local out = '$outdir/'..obj
	build('cc', out, '$srcdir/crt/'..obj:gsub('%.o$', '.c'))
	file('lib/'..obj, '644', out)
	table.insert(startfiles, out)
end
phony('startfiles', startfiles)

fetch 'git'
