cflags{
	'-D NDEBUG',
	'-I $dir',
	'-I $srcdir/Include',
	'-I $srcdir/Include/internal',
	'-isystem $builddir/pkg/linux-headers/include',
}

pkg.deps = {'pkg/linux-headers/headers'}
local libs = {}
local modules = load 'modules.lua'

if modules._ctypes then
	cflags{'-isystem $builddir/pkg/libffi/include'}
	table.insert(pkg.deps, 'pkg/libffi/headers')
	table.insert(libs, 'libffi/libffi.a')
end
if modules._hashlib or modules._ssl then
	cflags{'-isystem $builddir/pkg/libressl/include'}
	table.insert(pkg.deps, 'pkg/libressl/headers')
	table.insert(libs, {
		'libressl/libssl.a',
		'libressl/libcrypto.a',
	})
end
if modules.pyexpat then
	cflags{'-isystem $builddir/pkg/expat/include'}
	table.insert(pkg.deps, 'pkg/expat/headers')
	table.insert(libs, 'expat/libexpat.a.d')
end
if modules.zlib then
	cflags{'-isystem $builddir/pkg/zlib/include'}
	table.insert(pkg.deps, 'pkg/zlib/headers')
	table.insert(libs, 'zlib/libz.a')
end

local srcs = {}
sub('modules.ninja', function()
	cflags{'-D Py_BUILD_CORE_BUILTIN'}

	for _, mod in pairs(modules) do
		for _, src in ipairs(mod) do
			local obj = src..'.o'
			if not srcs[obj] then
				cc('Modules/'..src)
				srcs[obj] = true
			end
		end
	end
end)
srcs = table.keys(srcs)

cflags{'-D Py_BUILD_CORE'}

rule('makesetup', 'lua $dir/makesetup.lua $dir/modules.lua <$in >$out')
build('makesetup', '$outdir/config.c', {'$srcdir/Modules/config.c.in', '|', '$dir/makesetup.lua', '$dir/modules.lua'})

cc('Modules/getbuildinfo.c', nil, {
	cflags=[[$cflags -D 'DATE="Feb 19 2021"' -D 'TIME="13:32:09"']]
})
cc('Modules/getpath.c', nil, {
	cflags={
		'$cflags',
		[[-D 'PYTHONPATH=":plat-linux"']],
		[[-D 'PREFIX="/"']],
		[[-D 'EXEC_PREFIX="/"']],
		[[-D 'VERSION="3.9"']],
		[[-D 'VPATH=""']],
	},
})

local platform = 'linux'
local abiflags = ''
for line in iterlines('pyconfig.h', 1) do
	if line == '#define WITH_PYMALLOC 1' then
		abiflags = abiflags..'m'
	elseif line == '#define Py_DEBUG 1' then
		abiflags = abiflags..'d'
	end
end

cc('Python/getplatform.c', nil, {
	cflags=string.format([[$cflags -D 'PLATFORM="%s"']], platform),
})
cc('Python/initconfig.c', nil, {
	cflags=[[$cflags -D 'PLATLIBDIR="lib"']],
})
cc('Python/sysmodule.c', nil, {
	cflags=string.format([[$cflags -D 'ABIFLAGS="%s"']], abiflags),
})

lib('libpython.a', {expand{'Modules/', srcs}, paths[[
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
		call.c
		capsule.c
		cellobject.c
		classobject.c
		codeobject.c
		complexobject.c
		descrobject.c
		enumobject.c
		exceptions.c
		genericaliasobject.c
		genobject.c
		fileobject.c
		floatobject.c
		frameobject.c
		funcobject.c
		interpreteridobject.c
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
		picklebufobject.c
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
		token.c
		pegen/(pegen.c parse.c parse_string.c peg_api.c)
		myreadline.c parsetok.c tokenizer.c
	)
	Python/(
		_warnings.c
		Python-ast.c
		asdl.c
		ast.c
		ast_opt.c
		ast_unparse.c
		bltinmodule.c
		ceval.c
		codecs.c
		compile.c
		context.c
		errors.c
		frozenmain.c
		future.c
		getargs.c
		getcompiler.c
		getcopyright.c
		getplatform.c.o
		getversion.c
		graminit.c
		hamt.c
		hashtable.c
		import.c
		importdl.c
		initconfig.c.o
		marshal.c
		modsupport.c
		mysnprintf.c
		mystrtoul.c
		pathconfig.c
		peephole.c
		preconfig.c
		pyarena.c
		pyctype.c
		pyfpe.c
		pyhash.c
		pylifecycle.c
		pymath.c
		pystate.c
		pythonrun.c
		pytime.c
		bootstrap_hash.c
		structmember.c
		symtable.c
		sysmodule.c.o
		thread.c
		traceback.c
		getopt.c
		pystrcmp.c
		pystrtod.c
		pystrhex.c
		dtoa.c
		formatter_unicode.c
		fileutils.c
		dynload_stub.c
		frozen.c
	)
	$outdir/config.c
]]})

exe('python', {'Programs/python.c', 'libpython.a', expand{'$builddir/pkg/', libs}})
file('bin/python3', '755', '$outdir/python')
sym('bin/python', 'python3')

build('copy', '$outdir/python3.1', '$srcdir/Misc/python.man')
man{'$outdir/python3.1'}
sym('share/man/man1/python.1.gz', 'python3.1.gz')

for f in iterlines('pylibs.txt') do
	file('lib/python3.9/'..f, '644', '$srcdir/Lib/'..f)
end
file('lib/python3.9/_sysconfigdata_'..abiflags..'_'..platform..'_.py', '644', '$dir/lib/_sysconfigdata.py')
file('lib/python3.9/Makefile', '644', '$dir/lib/Makefile')
dir('lib/python3.9/lib-dynload', '755')

fetch 'curl'
