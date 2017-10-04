cflags{
	'-fwrapv',
	'-D NDEBUG',
	'-D Py_BUILD_CORE',
	'-I include',
	'-I $dir',
	'-I $srcdir/Include',
}

local sources = {}
local modules = {}
for line in io.lines(pkg.dir..'/Setup') do
	if #line > 0 and not line:find('^[*#]') then
		local i = line:find(' ', 1, true)
		modules[line:sub(1, i and i - 1)] = true
		while i do
			local j = line:find(' ', i + 1, true)
			sources[line:sub(i + 1, j and j - 1)] = true
			i = j
		end
	end
end
sources = table.keys(sources)

pkg.deps = {}
local libs = {}

if modules['_ctypes'] then
	cflags{'-I $builddir/pkg/libffi/include'}
	table.insert(pkg.deps, 'pkg/libffi/headers')
	table.insert(libs, 'libffi/libffi.a')
end
if modules['_hashlib'] or modules['_ssl'] then
	cflags{'-I $builddir/pkg/libressl/include'}
	table.insert(pkg.deps, 'pkg/libressl/headers')
	table.insert(libs, {
		'libressl/libssl.a',
		'libressl/libcrypto.a',
	})
end
if modules['pyexpat'] then
	cflags{'-I $builddir/pkg/expat/include'}
	table.insert(pkg.deps, 'pkg/expat/headers')
	table.insert(libs, 'expat/libexpat.a.d')
end
if modules['zlib'] then
	cflags{' -I $builddir/pkg/zlib/include'}
	table.insert(pkg.deps, 'pkg/zlib/headers')
	table.insert(libs, 'zlib/libz.a')
end

rule('makesetup', 'cd $outdir && $$OLDPWD/$srcdir/Modules/makesetup -s $$OLDPWD/$srcdir -m - $$OLDPWD/$in')
build('makesetup', '$outdir/config.c', {
	'$dir/Setup', '|', '$srcdir/Modules/makesetup', '$srcdir/Modules/config.c.in'
})

cc('Modules/getbuildinfo.c', nil, {
	cflags=[[$cflags -D 'DATE="Oct 3 2017"' -D 'TIME="01:52:02"']]
})
cc('Modules/getpath.c', nil, {
	cflags={
		'$cflags',
		[[-D 'PYTHONPATH=":plat-linux"']],
		[[-D 'PREFIX="/"']],
		[[-D 'EXEC_PREFIX="/"']],
		[[-D 'VERSION="3.6"']],
		[[-D 'VPATH=""']],
	},
})

local platform = 'linux'
local abiflags = ''
for line in io.lines(pkg.dir..'/pyconfig.h') do
	if line == '#define WITH_PYMALLOC 1' then
		abiflags = abiflags..'m'
	elseif line == '#define Py_DEBUG 1' then
		abiflags = abiflags..'d'
	end
end

cc('Python/getplatform.c', nil, {
	cflags=string.format([[$cflags -D 'PLATFORM="%s"']], platform),
})
cc('Python/sysmodule.c', nil, {
	cflags=string.format([[$cflags -D 'ABIFLAGS="%s"']], abiflags),
})

lib('libpython.a', {expand{'Modules/', sources}, paths[[
	Modules/(
		getbuildinfo.c.o
		getpath.c.o
		main.c
		gcmodule.c
	)
	Objects/(
		abstract.c
		accu.c
		boolobject.c
		bytes_methods.c
		bytearrayobject.c
		bytesobject.c
		cellobject.c
		classobject.c
		codeobject.c
		complexobject.c
		descrobject.c
		enumobject.c
		exceptions.c
		genobject.c
		fileobject.c
		floatobject.c
		frameobject.c
		funcobject.c
		iterobject.c
		listobject.c
		longobject.c
		dictobject.c
		odictobject.c
		memoryobject.c
		methodobject.c
		moduleobject.c
		namespaceobject.c
		object.c
		obmalloc.c
		capsule.c
		rangeobject.c
		setobject.c
		sliceobject.c
		structseq.c
		tupleobject.c
		typeobject.c
		unicodeobject.c
		unicodectype.c
		weakrefobject.c
	)
	Parser/(
		acceler.c
		grammar1.c
		listnode.c
		node.c
		parser.c
		bitset.c
		metagrammar.c
		firstsets.c
		grammar.c
		pgen.c
		myreadline.c parsetok.c tokenizer.c
	)
	Python/(
		_warnings.c
		Python-ast.c
		asdl.c
		ast.c
		bltinmodule.c
		ceval.c
		compile.c
		codecs.c
		dynamic_annotations.c
		errors.c
		frozenmain.c
		future.c
		getargs.c
		getcompiler.c
		getcopyright.c
		getplatform.c.o
		getversion.c
		graminit.c
		import.c
		importdl.c
		marshal.c
		modsupport.c
		mystrtoul.c
		mysnprintf.c
		peephole.c
		pyarena.c
		pyctype.c
		pyfpe.c
		pyhash.c
		pylifecycle.c
		pymath.c
		pystate.c
		pythonrun.c
		pytime.c
		random.c
		structmember.c
		symtable.c
		sysmodule.c.o
		traceback.c
		getopt.c
		pystrcmp.c
		pystrtod.c
		pystrhex.c
		dtoa.c
		formatter_unicode.c
		fileutils.c
		dynload_stub.c
		thread.c
		frozen.c
	)
	$outdir/config.c
]]})

exe('python', {'Programs/python.c', 'libpython.a', expand{'$builddir/pkg/', libs}})
file('bin/python3', '755', '$outdir/python')
sym('bin/python', 'python3')

for f in iterlines('pylibs.txt') do
	file('lib/python3.6/'..f, '644', '$srcdir/Lib/'..f)
end
file('lib/python3.6/_sysconfigdata_'..abiflags..'_'..platform..'_.py', '644', '$dir/lib/_sysconfigdata.py')
file('lib/python3.6/Makefile', '644', '$dir/lib/Makefile')
dir('lib/python3.6/lib-dynload', '755')

table.insert(pkg.inputs.gen, {'$dir/Setup', '$dir/pyconfig.h'})
fetch 'curl'
