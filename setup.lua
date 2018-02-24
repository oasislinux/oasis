#!/bin/lua

if not os.execute('test -f config.lua') then
	os.execute('cp config.def.lua config.lua')
end

dofile 'ninja.lua'
config = dofile 'config.lua'

local recurse = not arg[1]

function subgen(dir)
	local file = '$dir/'..dir..'/local.ninja'
	subninja(file)
	table.insert(pkg.inputs.ninja, '$dir/'..dir..'/ninja')
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
				'setup.lua',
				'ninja.lua',
				'config.lua',
				'sets.lua',
			},
			ninja={'$dir/local.ninja'},
			fetch={},
		},
		perms={},
	}
	local outdir = config.builddir..'/'..dir
	if not os.execute('mkdir -p '..outdir) then
		error('failed to create '..outdir)
	end
	io.output(dir..'/local.ninja.tmp')
	set('dir', dir)
	if dir ~= '.' then
		set('outdir', '$builddir/$dir')
		set('srcdir', '$dir/src')
	end
	load('gen.lua')

	build('gen', '$dir/local.ninja', {'|', pkg.inputs.gen})
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
		build('cat', '$outdir/root.index', pkg.inputs.index)
	else
		build('empty', '$outdir/root.index')
	end
	io.close()
	os.rename(dir..'/local.ninja.tmp', dir..'/local.ninja')
end

gen(arg[1] or '.')
