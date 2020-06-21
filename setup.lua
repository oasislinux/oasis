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

if not os.execute('test -f config.lua') then
	os.execute('cp '..basedir..'/config.def.lua config.lua')
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
			perms={},
			index={},
			fspec={implicit={}},
			gen={
				'$basedir/ninja.lua',
				'$basedir/sets.lua',
				'$basedir/setup.lua',
				'config.lua',
			},
			ninja={'$gendir/local.ninja'},
			fetch={},
		},
		perms={},
		fspec={},
	}
	assert(os.execute(('mkdir -p %s %s'):format(gendir, outdir)))
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

	if next(pkg.perms) then
		table.sort(pkg.perms, function(s1, s2)
			return s1:sub(8) < s2:sub(8)
		end)
		local f = assert(io.open(outdir..'/local.perms', 'w'))
		f:write(table.concat(pkg.perms, '\n'))
		f:write('\n')
		table.insert(pkg.inputs.perms, '$outdir/local.perms')
		f:close()
	end
	if next(pkg.fspec) then
		local f = assert(io.open(outdir..'/local.fspec', 'w'))
		for _, path in ipairs(table.keys(pkg.fspec)) do
			f:write(('/%s\n'):format(path))
			for k, v in pairs(pkg.fspec[path]) do
				f:write(('%s=%s\n'):format(k, v))
			end
			f:write('\n')
		end
		f:close()
		table.insert(pkg.inputs.fspec, '$outdir/local.fspec')
	end
	if next(pkg.inputs.perms) then
		build('mergeperms', '$outdir/root.perms', pkg.inputs.perms)
	else
		build('empty', '$outdir/root.perms')
	end
	if next(pkg.inputs.index) then
		build('cat', '$outdir/root.index', pkg.inputs.index, {
			description='	INDEX	$outdir/root.index',
		})
	else
		build('empty', '$outdir/root.index')
	end
	if next(pkg.inputs.fspec) then
		if next(pkg.inputs.fspec.implicit) then
			table.insert(pkg.inputs.fspec, {'|', pkg.inputs.fspec.implicit})
		end
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
		os.execute('ln -sf local.ninja build.ninja')
	end
end

function subgen(dir)
	local file = '$gendir/'..dir..'/local.ninja'
	subninja(file)
	table.insert(pkg.inputs.ninja, '$gendir/'..dir..'/ninja')
	table.insert(pkg.inputs.index, '$outdir/'..dir..'/root.index')
	table.insert(pkg.inputs.perms, '$outdir/'..dir..'/root.perms')
	table.insert(pkg.inputs.fspec, '$outdir/'..dir..'/root.fspec')
	local cmd = string.format('test -f %s/%s/local.ninja', pkg.gendir, dir)
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
