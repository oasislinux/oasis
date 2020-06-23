#!/bin/lua

-- Lua 5.1 compatibility
do
	local os_execute = os.execute
	os.execute = function(cmd)
		local ret = os_execute(cmd)
		return ret == true or ret == 0
	end
end

basedir = arg[0]:match('(.*)/') or '.'

if not os.execute('exec test -f config.lua') then
	os.execute('exec cp '..basedir..'/config.def.lua config.lua')
end

dofile(basedir..'/ninja.lua')
config = dofile 'config.lua'
if not config.prefix then
	config.prefix = ''
end

local recurse = not arg[1]

local function gen(gendir)
	local dir = basedir..'/'..gendir
	local outdir = config.builddir..'/'..gendir
	pkg={
		name=gendir:match('[^/]*$'),
		dir=dir,
		gendir=gendir,
		srcdir=dir..'/src',
		outdir=outdir,
		inputs={
			index={},
			fspec={},
			gen={
				'$basedir/ninja.lua',
				'$basedir/sets.lua',
				'$basedir/setup.lua',
				'config.lua',
			},
			ninja={'$gendir/local.ninja'},
			fetch={},
		},
		fspec={},
	}
	assert(os.execute(('exec mkdir -p %s %s'):format(gendir, outdir)))
	io.output(gendir..'/local.ninja.tmp')
	set('gendir', gendir)
	if gendir ~= '.' then
		set('dir', '$basedir/$gendir')
		set('outdir', '$builddir/$gendir')
		set('srcdir', '$dir/src')
	end
	load('gen.lua')

	build('gen', '$gendir/local.ninja', {'|', pkg.inputs.gen})
	phony('ninja', pkg.inputs.ninja)

	if pkg.hdrs then
		phony('headers', pkg.hdrs)
		if pkg.hdrs.install then
			for hdr in iterstrings(pkg.hdrs) do
				if not hdr:hasprefix('$outdir/include/') then
					error('header is not in $outdir/include: '..hdr)
				end
				file(hdr:sub(9), '644', hdr)
			end
		end
	end
	if pkg.deps then
		phony('deps', pkg.deps)
	end

	if next(pkg.fspec) then
		local out = outdir..'/local.fspec'
		local tmp = out..'.tmp'
		local f = assert(io.open(tmp, 'w'))
		local srcs = {}
		for _, path, fspec in sortedpairs(pkg.fspec) do
			f:write(('/%s\n'):format(path))
			for _, k in ipairs{'type', 'mode', 'source', 'target'} do
				local v = fspec[k]
				if v then
					f:write(('%s=%s\n'):format(k, v))
				end
			end
			f:write('\n')
			local src = fspec.source
			if src then
				srcs[#srcs + 1] = src
			end
		end
		f:close()
		if os.execute(('exec cmp -s %s %s'):format(tmp, out)) then
			os.remove(tmp)
		else
			os.rename(tmp, out)
		end
		build('fspec-hash', '$outdir/local-hashed.fspec', {'$outdir/local.fspec', '|', '$builddir/pkg/fspec-sync/host/fspec-hash', srcs})
		table.insert(pkg.inputs.fspec, '$outdir/local-hashed.fspec')
	end
	if next(pkg.inputs.index) then
		build('cat', '$outdir/root.index', pkg.inputs.index, {
			description='	INDEX	$outdir/root.index',
		})
	else
		build('empty', '$outdir/root.index')
	end
	if next(pkg.inputs.fspec) then
		build('cat', '$outdir/root.fspec', pkg.inputs.fspec, {
			description = '	FSPEC	$outdir/root.fspec',
		})
	else
		build('empty', '$outdir/root.fspec')
	end
	build('phony', '$dir/root', pkg.inputs.root)
	io.close()
	os.rename(gendir..'/local.ninja.tmp', gendir..'/local.ninja')
	if gendir == '.' then
		os.execute('exec ln -sf local.ninja build.ninja')
	end
end

function subgen(dir)
	local file = '$gendir/'..dir..'/local.ninja'
	subninja(file)
	table.insert(pkg.inputs.ninja, '$gendir/'..dir..'/ninja')
	table.insert(pkg.inputs.index, '$outdir/'..dir..'/root.index')
	table.insert(pkg.inputs.fspec, '$outdir/'..dir..'/root.fspec')
	local cmd = ('exec test -f %s/%s/local.ninja'):format(pkg.gendir, dir)
	if recurse or not os.execute(cmd) then
		local oldpkg, oldout = pkg, io.output()
		if pkg.gendir ~= '.' then
			dir = pkg.gendir..'/'..dir
		end
		gen(dir)
		pkg = oldpkg
		io.output(oldout)
	end
end

gen(arg[1] or '.')
