#!/bin/lua

basedir = arg[0]:match('(.*)/') or '.'

if not os.execute('test -f config.lua') then
	os.execute('cp '..basedir..'/config.def.lua config.lua')
end

dofile(basedir..'/ninja.lua')
config = dofile 'config.lua'

local recurse = not arg[1]

function subgen(dir)
	local file = '$gendir/'..dir..'/local.ninja'
	subninja(file)
	table.insert(pkg.inputs.ninja, '$gendir/'..dir..'/ninja')
	table.insert(pkg.inputs.index, '$outdir/'..dir..'/root.index')
	table.insert(pkg.inputs.perms, '$outdir/'..dir..'/root.perms')
	local cmd = string.format('test -f %s/%s/local.ninja', pkg.dir, dir)
	if recurse or not os.execute(cmd) then
		local oldpkg, oldout = pkg, io.output()
		if pkg.dir ~= '.' then
			dir = pkg.dir..'/'..dir
		end
		gen(dir)
		pkg = oldpkg
		io.output(oldout)
	end
end

function gen(dir)
	pkg={
		name=dir:match('[^/]*$'),
		dir=dir,
		inputs={
			perms={},
			index={},
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
	}
	if not os.execute('mkdir -p '..dir) then
		error('failed to create '..dir)
	end
	local outdir = config.builddir..'/'..dir
	if not os.execute('mkdir -p '..outdir) then
		error('failed to create '..outdir)
	end
	io.output(dir..'/local.ninja.tmp')
	set('gendir', dir)
	if dir ~= '.' then
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
		local f = io.open(outdir..'/local.perms', 'w')
		table.insert(pkg.perms, '')
		f:write(table.concat(pkg.perms, '\n'))
		table.insert(pkg.inputs.perms, '$outdir/local.perms')
		f:close()
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
	build('phony', '$dir/root', pkg.inputs.root)
	io.close()
	os.rename(dir..'/local.ninja.tmp', dir..'/local.ninja')
	if dir == '.' then
		os.execute('ln -sf local.ninja build.ninja')
	end
end

gen(arg[1] or '.')
