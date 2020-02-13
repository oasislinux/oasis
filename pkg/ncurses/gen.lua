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
	toolchain(config.host)
	cflags{'$common_cflags', '-D USE_BUILD_CC'}
	exe('make_keys', {'ncurses/tinfo/make_keys.c'}, {'$gendir/headers', '$outdir/names.c'})
	exe('make_hash', {'ncurses/tinfo/make_hash.c'}, {'$gendir/headers', '$outdir/hashsize.h'})
end)

local caps = {
	'$srcdir/include/Caps',
	'$srcdir/include/Caps-ncurses',
}

build('sed', '$outdir/curses.head', {'$srcdir/include/curses.h.in', '|', '$dir/subst.sed'}, {
	expr='-f $dir/subst.sed',
})
rule('mkkeydefs', '{ cat $outdir/curses.head && sh $srcdir/include/MKkey_defs.sh $in && cat $srcdir/include/curses.wide $srcdir/include/curses.tail; } >$out')
build('mkkeydefs', '$outdir/include/curses.h', {caps, '|',
	'$outdir/curses.head',
	'$srcdir/include/curses.wide',
	'$srcdir/include/curses.tail',
	'$srcdir/include/MKkey_defs.sh',
})

rule('mkhashsize', 'sh $srcdir/include/MKhashsize.sh $in >$out')
build('mkhashsize', '$outdir/hashsize.h', {caps, '|', '$srcdir/include/MKhashsize.sh'})

rule('mkkeyslist', 'sh $srcdir/ncurses/tinfo/MKkeys_list.sh $in | LC_ALL=C sort >$out')
build('mkkeyslist', '$outdir/keys.list', {caps, '|', '$srcdir/ncurses/tinfo/MKkeys_list.sh'})

rule('mkkeys', '$outdir/make_keys $in >$out')
build('mkkeys', '$outdir/init_keytry.h', {'$outdir/keys.list', '|', '$outdir/make_keys'})

rule('mkdefs', 'sh $srcdir/include/MKncurses_def.sh $in >$out')
build('mkdefs', '$outdir/ncurses_def.h', {'$srcdir/include/ncurses_defs', '|', '$srcdir/include/MKncurses_def.sh'})

rule('mkparam', '$srcdir/include/MKparametrized.sh $in >$out')
build('mkparam', '$outdir/parametrized.h', {caps, '|', '$srcdir/include/MKparametrized.sh'})

build('sed', '$outdir/MKterm.h.awk', {'$srcdir/include/MKterm.h.awk.in', '|', '$dir/subst.sed'}, {
	expr='-f $dir/subst.sed',
})

for _, f in ipairs{'ncurses_dll.h', 'termcap.h', 'unctrl.h'} do
	build('sed', '$outdir/include/'..f, {'$srcdir/include/'..f..'.in', '|', '$dir/subst.sed'}, {
		expr='-f $dir/subst.sed',
	})
end

rule('mkterm', 'awk -f $outdir/MKterm.h.awk $in >$out')
build('mkterm', '$outdir/include/term.h', {caps, '|', '$outdir/MKterm.h.awk'})

build('awk', '$outdir/codes.c', {caps, '|', '$srcdir/ncurses/tinfo/MKcodes.awk'}, {
	expr='-f $srcdir/ncurses/tinfo/MKcodes.awk bigstrings=1',
})

rule('mkcaptab', 'MAKE_HASH=$outdir/make_hash sh -e $srcdir/ncurses/tinfo/MKcaptab.sh awk 1 $srcdir/ncurses/tinfo/MKcaptab.awk $in >$out')
build('mkcaptab', '$outdir/comp_captab.c', {caps, '|',
	'$outdir/make_hash',
	'$srcdir/tinfo/MKcaptab.awk',
	'$srcdir/tinfo/MKcaptab.sh',
})

rule('mkuserdefs', 'MAKE_HASH=$outdir/make_hash sh -e $srcdir/ncurses/tinfo/MKuserdefs.sh awk 1 $in >$out')
build('mkuserdefs', '$outdir/comp_userdefs.c', {caps, '|',
	'$outdir/make_hash',
	'$srcdir/tinfo/MKuserdefs.sh',
})

rule('mkfallback', 'sh $srcdir/ncurses/tinfo/MKfallback.sh /dev/null /dev/null /dev/null /dev/null >$out')
build('mkfallback', '$outdir/fallback.c', {'|', '$srcdir/ncurses/tinfo/MKfallback.sh'})

build('awk', '$outdir/lib_keyname.c', '$outdir/keys.list', {
	expr='-f $srcdir/ncurses/base/MKkeyname.awk bigstrings=1',
})

build('awk', '$outdir/names.c', {caps, '|', '$srcdir/ncurses/tinfo/MKnames.awk'}, {
	expr='-f $srcdir/ncurses/tinfo/MKnames.awk bigstrings=1',
})

rule('mktermsort', 'sh $srcdir/progs/MKtermsort.sh awk $in >$out')
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
	'$gendir/headers',
	'$outdir/hashsize.h',
	'$outdir/init_keytry.h',
	'$outdir/ncurses_def.h',
	'$outdir/parametrized.h',
	'$outdir/termsort.c',
}

srcs = load('sources.lua')

lib('libncurses.a', {
	srcs.base,
	srcs.widechar,
	srcs.termlib,
	srcs.ext_funcs,
	srcs.ext_tinfo,
})
file('lib/libncurses.a', '644', '$outdir/libncurses.a')

lib('libtic.a', srcs.ticlib)

cc('progs/reset_cmd.c')
cc('progs/tparm_type.c')
cc('progs/transform.c')
cc('progs/tty_settings.c')

exe('infocmp', [[
	progs/(infocmp.c dump_entry.c.o)
	libtic.a
	libncurses.a
]])
file('bin/infocmp', '755', '$outdir/infocmp')

exe('tic', [[
	progs/(tic.c dump_entry.c tparm_type.c.o transform.c.o)
	libtic.a
	libncurses.a
]])
file('bin/tic', '755', '$outdir/tic')

exe('tput', [[
	progs/(tput.c clear_cmd.c reset_cmd.c.o tparm_type.c.o transform.c.o tty_settings.c.o)
	libncurses.a
]])
file('bin/tput', '755', '$outdir/tput')

exe('tset', [[
	progs/(tset.c reset_cmd.c.o transform.c.o tty_settings.c.o)
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
