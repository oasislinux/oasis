cflags{
	'-I $outdir',
	'-I $srcdir',
	'-I $srcdir/mi',
	'-I $srcdir/parse',
	'-I $srcdir/util',
}

yacc('gram', '$srcdir/parse/gram.y')
build('copy', '$outdir/gram.h', '$outdir/gram.tab.h')

lib('libparse.a', [[
	$outdir/gram.tab.c
	parse/(
		dump.c
		err.c
		export.c
		fold.c
		infer.c
		names.c
		node.c
		specialize.c
		stab.c
		tok.c
		type.c
		use.c
	)
]], {'$outdir/gram.h'})
lib('libmi.a', 'mi/(cfg.c flatten.c dfcheck.c match.c reaching.c)')
lib('libutil.a', 'util/(alloc.c bitset.c htab.c pack.c util.c)')

exe('bin/6m', [[
	6/(
		blob.c
		gen.c
		gengas.c
		genp9.c
		isel.c
		locs.c
		main.c
		ra.c
		peep.c
		simp.c
		typeinfo.c
	)
	libmi.a libparse.a libutil.a
]])
file('bin/6m', '755', '$outdir/bin/6m')

exe('bin/muse', {'muse/muse.c', 'libparse.a', 'libutil.a'})
file('bin/muse', '755', '$outdir/bin/muse')

build('cat', '$outdir/_myrrt.s', {
	'$srcdir/rt/start-linux.s',
	'$srcdir/rt/common.s',
	'$srcdir/rt/abort-linux.s',
})
build('as', '$outdir/_myrrt.o', '$outdir/_myrrt.s')
file('lib/myr/_myrrt.o', '644', '$outdir/_myrrt.o')

set('mcflags', {
	'-I $outdir/lib/sys',
	'-I $outdir/lib/std',
	'-I $outdir/lib/bio',
	'-I $outdir/lib/regex',
	'-I $outdir/lib/thread',
})

include '$dir/myr.ninja'
for lib in iterpaths('bio crypto date escfmt fileutil http inifile json regex std sys testr thread') do
	file('lib/myr/lib'..lib..'.use', '644', '$outdir/lib/'..lib..'/lib'..lib..'.use')
	file('lib/myr/lib'..lib..'.a', '644', '$outdir/lib/'..lib..'/lib'..lib..'.a')
end
file('bin/mbld', '755', '$outdir/mbld/mbld')

man{'doc/6m.1', 'doc/muse.1', 'mbld/mbld.1'}

fetch 'git'
