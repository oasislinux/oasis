set('common_cflags', {
	'-D NDEBUG',
	'-I $dir',
	'-I $outdir',
	'-I $outdir/include',
	'-I $srcdir/include',
	'-I $srcdir/ncurses',
	'-I $srcdir/progs',
})
cflags{'$common_cflags'}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'$common_cflags', '-D USE_BUILD_CC'}
	exe('make_keys', {'ncurses/tinfo/make_keys.c'}, {
		'$outdir/names.c',
		'$outdir/include/curses.h',
		'$outdir/include/ncurses_dll.h',
	})
	exe('make_hash', {'ncurses/tinfo/make_hash.c'}, {
		'$outdir/hashsize.h',
		'$outdir/include/curses.h',
	})
end)

build('sed', '$outdir/curses.head', {'$srcdir/include/curses.h.in', '|', '$dir/subst.sed'}, {
	expr='-f $dir/subst.sed',
})
rule('mkkeydefs', '{ cat $outdir/curses.head && sh $srcdir/include/MKkey_defs.sh $in && cat $srcdir/include/curses.wide $srcdir/include/curses.tail; } >$out.tmp && mv $out.tmp $out')
build('mkkeydefs', '$outdir/include/curses.h', {'$srcdir/include/Caps', '|',
	'$outdir/curses.head',
	'$srcdir/include/curses.wide',
	'$srcdir/include/curses.tail',
	'$srcdir/include/MKkey_defs.sh',
})

rule('mkhashsize', 'sh $srcdir/include/MKhashsize.sh $in >$out.tmp && mv $out.tmp $out')
build('mkhashsize', '$outdir/hashsize.h', {'$srcdir/include/Caps', '|', '$srcdir/include/MKhashsize.sh'})

rule('mkkeyslist', 'sh $srcdir/ncurses/tinfo/MKkeys_list.sh $in | LC_ALL=C sort >$out.tmp && mv $out.tmp $out')
build('mkkeyslist', '$outdir/keys.list', {'$srcdir/include/Caps', '|', '$srcdir/ncurses/tinfo/MKkeys_list.sh'})

rule('mkkeys', '$outdir/make_keys $in >$out.tmp && mv $out.tmp $out')
build('mkkeys', '$outdir/init_keytry.h', {'$outdir/keys.list', '|', '$outdir/make_keys'})

rule('mkdefs', 'sh $srcdir/include/MKncurses_def.sh $in >$out.tmp && mv $out.tmp $out')
build('mkdefs', '$outdir/ncurses_def.h', {'$srcdir/include/ncurses_defs', '|', '$srcdir/include/MKncurses_def.sh'})

build('sed', '$outdir/include/ncurses_dll.h', '$srcdir/include/ncurses_dll.h.in', {
	expr='s,@NCURSES_WRAP_PREFIX@,_nc_,',
})

rule('mkparam', '$srcdir/include/MKparametrized.sh $in >$out.tmp && mv $out.tmp $out')
build('mkparam', '$outdir/parametrized.h', {'$srcdir/include/Caps', '|', '$srcdir/include/MKparametrized.sh'})

build('sed', '$outdir/MKterm.h.awk', {'$srcdir/include/MKterm.h.awk.in', '|', '$dir/subst.sed'}, {
	expr='-f $dir/subst.sed',
})

for _, f in ipairs{'termcap.h', 'unctrl.h'} do
	build('sed', '$outdir/include/'..f, {'$srcdir/include/'..f..'.in', '|', '$dir/subst.sed'}, {
		expr='-f $dir/subst.sed',
	})
end

rule('mkterm', 'awk -f $outdir/MKterm.h.awk $in >$out.tmp && mv $out.tmp $out')
build('mkterm', '$outdir/include/term.h', {'$srcdir/include/Caps', '|', '$outdir/MKterm.h.awk'})

build('awk', '$outdir/codes.c', {'$srcdir/include/Caps', '|', '$srcdir/ncurses/tinfo/MKcodes.awk'}, {
	expr='-f $srcdir/ncurses/tinfo/MKcodes.awk bigstrings=1',
})

rule('mkcaptab', '(cd $outdir && $$OLDPWD/$srcdir/ncurses/tinfo/MKcaptab.sh awk 1 $$OLDPWD/$srcdir/ncurses/tinfo/MKcaptab.awk $$OLDPWD/$in) >$out.tmp && mv $out.tmp $out')
build('mkcaptab', '$outdir/comp_captab.c', {'$srcdir/include/Caps', '|',
	'$outdir/make_hash',
	'$srcdir/tinfo/MKcaptab.awk',
	'$srcdir/tinfo/MKcaptab.sh',
})

rule('mkfallback', 'sh $srcdir/ncurses/tinfo/MKfallback.sh /dev/null /dev/null /dev/null >$out.tmp && mv $out.tmp $out')
build('mkfallback', '$outdir/fallback.c', {'|', '$srcdir/ncurses/tinfo/MKfallback.sh'})

build('awk', '$outdir/lib_keyname.c', '$outdir/keys.list', {
	expr='-f $srcdir/ncurses/base/MKkeyname.awk bigstrings=1',
})

build('awk', '$outdir/names.c', {'$srcdir/include/Caps', '|', '$srcdir/ncurses/tinfo/MKnames.awk'}, {
	expr='-f $srcdir/ncurses/tinfo/MKnames.awk bigstrings=1',
})

rule('mktermsort', 'sh $srcdir/progs/MKtermsort.sh awk $in >$out.tmp && mv $out.tmp $out')
build('mktermsort', '$outdir/termsort.c', {'$srcdir/include/Caps', '|', '$srcdir/progs/MKtermsort.sh'})

build('awk', '$outdir/unctrl.c', {'/dev/null', '|', '$srcdir/ncurses/base/MKunctrl.awk'}, {
	expr='-f $srcdir/ncurses/base/MKunctrl.awk bigstrings=1',
})

pkg.hdrs = {
	'$outdir/include/curses.h',
	'$outdir/include/ncurses_dll.h',
	'$outdir/include/term.h',
	'$outdir/include/termcap.h',
	'$outdir/include/unctrl.h',
	install=true,
}
pkg.deps = {
	'$dir/headers',
	'$outdir/hashsize.h',
	'$outdir/init_keytry.h',
	'$outdir/ncurses_def.h',
	'$outdir/parametrized.h',
	'$outdir/termsort.c',
}

lib('libncurses.a', lines('sources.txt'))
file('lib/libncurses.a', '644', '$outdir/libncurses.a')

cc('progs/transform.c')

exe('tic', [[
	progs/(tic.c dump_entry.c tparm_type.c transform.c.o)
	ncurses/(
		tinfo/(
			alloc_entry.c
			captoinfo.c
			comp_expand.c
			comp_parse.c
			comp_scan.c
			parse_entry.c
			write_entry.c
		)
		trace/lib_trace.c
	)
	libncurses.a
]])
file('bin/tic', '755', '$outdir/tic')

exe('tset', [[
	progs/(tset.c reset_cmd.c transform.c.o tty_settings.c)
	libncurses.a
]])
file('bin/tset', '755', '$outdir/tset')
sym('bin/reset', 'tset')

for _, f in ipairs{'tic.1m', 'tset.1'} do
	local out = '$outdir/'..f
	build('sed', out, {'$srcdir/man/'..f, '|', '$dir/subst.sed'}, {
		expr='-f $dir/subst.sed',
	})
	man({out}, '1')
end
sym('share/man/man1/reset.1.gz', 'tset.1.gz')

local terms = {'dumb', 'linux', 'tmux', 'tmux-256color', 'xterm', 'xterm-256color'}
local terminfo = {}
for _, term in ipairs(terms) do
	table.insert(terminfo, term:sub(1, 1)..'/'..term)
end
build('tic', expand{'$outdir/terminfo/', terminfo}, '$srcdir/misc/terminfo.src', {
	ticflags={
		'-o $outdir/terminfo',
		'-e', table.concat(terms, ','),
		'-x',
	},
})
for _, f in ipairs(terminfo) do
	file('share/terminfo/'..f, '644', '$outdir/terminfo/'..f)
end

fetch 'curl'
