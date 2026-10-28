cflags{
	'-std=c11',  -- otherwise Modules/mathmodule.c tries to use C23 issubnormal
	'-D NDEBUG',
	'-I $outdir',
	'-I $srcdir',
	'-I $srcdir/Include',
	'-I $srcdir/Include/internal',
	'-I $srcdir/Modules/_hacl',
	'-I $srcdir/Modules/_hacl/include',
	'-I $srcdir/Modules/expat',
	'-isystem $builddir/pkg/linux-headers/include',
}

build('cat', '$outdir/pyconfig.h', {
	'$builddir/probe/HAVE_STATX',
	'$dir/pyconfig.h',
})

pkg.deps = {
	'$outdir/pyconfig.h',
	'pkg/linux-headers/headers'
}
local libs = {}
local modules = load 'modules.lua'

if modules._ctypes then
	cflags{'-isystem $builddir/pkg/libffi/include'}
	table.insert(pkg.deps, 'pkg/libffi/headers')
	table.insert(libs, 'libffi/libffi.a')
end
if modules._hashlib then
	cflags{'-isystem $builddir/pkg/bearssl/include'}
	table.insert(pkg.deps, 'pkg/bearssl/headers')
	table.insert(libs, '$builddir/pkg/bearssl/libbearssl.a')
end
if modules._ssl then
	cflags{'-isystem $builddir/pkg/libressl/include'}
	table.insert(pkg.deps, 'pkg/libressl/headers')
	table.insert(libs, {
		'$builddir/pkg/libressl/libssl.a',
		'$builddir/pkg/libressl/libcrypto.a',
	})
end
if modules.pyexpat then
	cflags{'-isystem $builddir/pkg/expat/include'}
	table.insert(pkg.deps, 'pkg/expat/headers')
	table.insert(libs, '$builddir/pkg/expat/libexpat.a.d')
end
if modules.zlib then
	cflags{'-isystem $builddir/pkg/zlib/include'}
	table.insert(pkg.deps, 'pkg/zlib/headers')
	table.insert(libs, '$builddir/pkg/zlib/libz.a')
end
if modules._blake2 or modules._sha3 then
	table.insert(libs, 'libhacl.a')
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
	cflags=[[$cflags -D 'DATE="Oct 21 2026"' -D 'TIME="08:54:43"']]
})
cc('Modules/getpath.c', nil, {
	cflags={
		'$cflags',
		[[-D 'PYTHONPATH=":plat-linux"']],
		[[-D 'PREFIX="/"']],
		[[-D 'EXEC_PREFIX="/"']],
		[[-D 'VERSION="3.15"']],
		[[-D 'VPATH=""']],
		[[-D 'PLATLIBDIR="lib"']],
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

cc('Modules/_hacl/Lib_Memzero0.c', nil, {
	cflags='$cflags -D _GNU_SOURCE',
})
lib('libhacl.a', [[
	Modules/_hacl/(
		Hacl_Hash_SHA3.c
		Hacl_Hash_Blake2s.c
		Hacl_Hash_Blake2b.c
		Lib_Memzero0.c.o
	)
]])

lib('libpython.a', {expand{'Modules/', srcs}, paths[[
	Modules/(
		getbuildinfo.c.o
		getpath.c.o
		main.c
		gcmodule.c
	)
	Objects/(
		abstract.c
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
		interpolationobject.c
		iterobject.c
		lazyimportobject.c
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
		sentinelobject.c
		setobject.c
		sliceobject.c
		structseq.c
		templateobject.c
		tupleobject.c
		typeobject.c
		typevarobject.c
		unicode_format.c
		unicode_formatter.c
		unicode_writer.c
		unicodectype.c
		unicodeobject.c
		unionobject.c
		weakrefobject.c
	)
	Parser/(
		token.c
		pegen.c
		pegen_errors.c
		action_helpers.c
		parser.c
		string_parser.c
		peg_api.c
		lexer/(buffer.c lexer.c state.c)
		tokenizer/(
			file_tokenizer.c
			readline_tokenizer.c
			string_tokenizer.c
			utf8_tokenizer.c
			helpers.c
		)
		myreadline.c
	)
	Python/(
		_contextvars.c
		_warnings.c
		Python-ast.c
		Python-tokenize.c
		asdl.c
		assemble.c
		ast.c
		ast_preprocess.c
		ast_unparse.c
		bltinmodule.c
		brc.c
		ceval.c
		codecs.c
		codegen.c
		compile.c
		context.c
		critical_section.c
		crossinterp.c
		dynamic_annotations.c
		errors.c
		flowgraph.c
		frame.c
		frozenmain.c
		future.c
		gc.c
		gc_free_threading.c
		gc_gil.c
		getargs.c
		getcompiler.c
		getcopyright.c
		getplatform.c.o
		getversion.c
		ceval_gil.c
		hamt.c
		hashtable.c
		import.c
		importdl.c
		index_pool.c
		initconfig.c.o
		interpconfig.c
		instrumentation.c
		instruction_sequence.c
		intrinsics.c
		jit.c
		jit_publish.c
		legacy_tracing.c
		lock.c
		marshal.c
		modsupport.c
		mysnprintf.c
		mystrtoul.c
		object_stack.c
		optimizer.c
		optimizer_analysis.c
		optimizer_symbols.c
		parking_lot.c
		pathconfig.c
		preconfig.c
		pyarena.c
		pyctype.c
		pyfpe.c
		pyhash.c
		pylifecycle.c
		pymath.c
		pystate.c
		pystats.c
		pythonrun.c
		pytime.c
		qsbr.c
		bootstrap_hash.c
		specialize.c
		slots.c
		slots_generated.c
		stackrefs.c
		structmember.c
		symtable.c
		sysmodule.c.o
		thread.c
		traceback.c
		tracemalloc.c
		uniqueid.c
		getopt.c
		pystrcmp.c
		pystrtod.c
		pystrhex.c
		dtoa.c
		fileutils.c
		suggestions.c
		perf_trampoline.c
		perf_jit_trampoline.c
		jit_unwind.c
		remote_debugging.c
		dynload_stub.c

		frozen.c
	)
	$outdir/config.c
]]})

exe('python', {'Programs/python.c', 'libpython.a', libs})
file('bin/python3', '755', '$outdir/python')
sym('bin/python', 'python3')

build('copy', '$outdir/python3.1', '$srcdir/Misc/python.man')
man{'$outdir/python3.1'}
sym('share/man/man1/python.1.gz', 'python3.1.gz')

for f in iterlines('pylibs.txt') do
	file('lib/python3.15/'..f, '644', '$srcdir/Lib/'..f)
end
file('lib/python3.15/_sysconfigdata_'..abiflags..'_'..platform..'_.py', '644', '$dir/lib/_sysconfigdata.py')
file('lib/python3.15/Makefile', '644', '$dir/lib/Makefile')
dir('lib/python3.15/lib-dynload', '755')

fetch 'curl'
