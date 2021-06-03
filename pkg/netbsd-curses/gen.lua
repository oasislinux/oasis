cflags{
	'-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
	'-D TERMINFO_DB',
	([[-D '_PATH_TERMINFO="%s/share/misc/terminfo"']]):format(config.prefix),
	'-I $srcdir/compat',
	'-I $srcdir/lib/libcurses',
	'-I $srcdir/lib/libterminfo',
	'-I $srcdir/lib/libform',
	'-I $srcdir/lib/libmenu',
	'-I $srcdir/lib/libpanel',
	'-I $outdir',
}

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{
		'-I $srcdir/compat',
		'-I $srcdir/lib/libterminfo',
	}
	set('outdir', '$outdir/host')

	cc('compat/mi_vector_hash.c')
	build('cc', '$outdir/hash.c.o', '$outdir/../hash.c')

	exe('nbperf', [[
		usr.bin/nbperf/(
			nbperf.c
			nbperf-bdz.c nbperf-chm.c nbperf-chm3.c
			graph2.c graph3.c
		)
		compat/mi_vector_hash.c.o
	]])

	exe('tic', [[
		usr.bin/tic/tic.c
		lib/libterminfo/compile.c
		compat/cdbw.c
		compat/mi_vector_hash.c.o
		hash.c.o
	]])
end)

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/lib/libcurses', {'curses.h', 'unctrl.h'}),
	copy('$outdir/include', '$srcdir/lib/libterminfo', {'term.h', 'termcap.h'}),
	copy('$outdir/include', '$srcdir/lib/libpanel', {'panel.h'}),
	install=true,
}
pkg.deps = {
	'$outdir/compiled_terms.c',
	'$outdir/termcap_hash.c',
	'$outdir/hash.c',
}

rule('tic', '$outdir/host/tic $ticflags -o $out $in $terms')
build('tic', '$outdir/compiled_terms.c', {'$srcdir/share/terminfo/terminfo', '|', '$outdir/host/tic'}, {
	ticflags='-Sx',
	terms='dumb',
})
build('tic', '$outdir/terminfo.cdb', {'$srcdir/share/terminfo/terminfo', '|', '$outdir/host/tic'}, {
	ticflags='-x',
	terms='ansi dumb vt100 vt220 xterm xterm-256color st st-256color',
})
file('share/misc/terminfo.cdb', '644', '$outdir/terminfo.cdb')

rule('genhash', 'TOOL_NBPERF=$outdir/host/nbperf $srcdir/lib/libterminfo/genhash $in >$out')
build('genhash', '$outdir/hash.c', {
	'$srcdir/lib/libterminfo/term.h',
	'|', '$srcdir/lib/libterminfo/genhash', '$outdir/host/nbperf',
})

rule('genthash', 'TOOL_NBPERF=$outdir/host/nbperf $srcdir/lib/libterminfo/genthash $in >$out')
build('genthash', '$outdir/termcap_hash.c', {
	'$srcdir/lib/libterminfo/termcap_map.c',
	'|', '$srcdir/lib/libterminfo/genthash', '$outdir/host/nbperf',
})

lib('libcurses.a', [[
	lib/libcurses/(
		acs.c addbytes.c addch.c addchnstr.c addnstr.c attributes.c
		background.c bell.c border.c box.c chgat.c clear.c clearok.c
		clrtobot.c clrtoeol.c color.c copywin.c cr_put.c
		ctrace.c cur_hash.c curs_set.c
		curses.c delch.c deleteln.c delwin.c echochar.c erase.c fileio.c
		flushok.c fullname.c getch.c getstr.c getyx.c id_subwins.c idlok.c
		idcok.c immedok.c inch.c inchstr.c initscr.c insch.c insdelln.c
		insertln.c insstr.c instr.c keypad.c keyname.c leaveok.c line.c
		meta.c mouse.c move.c
		mvwin.c newwin.c nodelay.c notimeout.c overlay.c overwrite.c pause.c
		printw.c putchar.c refresh.c resize.c ripoffline.c scanw.c screen.c
		scroll.c scrollok.c setterm.c slk.c standout.c syncok.c timeout.c
		toucholap.c touchwin.c tstp.c tty.c unctrl.c underscore.c version.c

		cchar.c add_wch.c add_wchstr.c addwstr.c echo_wchar.c ins_wch.c
		ins_wstr.c get_wch.c get_wstr.c in_wch.c in_wchstr.c
		inwstr.c
	)
	libterminfo.a
]])
file('lib/libcurses.a', '644', '$outdir/libcurses.a')

lib('libterminfo.a', [[
	lib/libterminfo/(
		term.c ti.c setupterm.c curterm.c tparm.c tputs.c
		compile.c
		termcap.c
	)
	compat/cdbr.c
	compat/mi_vector_hash.c
	$outdir/hash.c
]])
file('lib/libterminfo.a', '644', '$outdir/libterminfo.a')

lib('libpanel.a', [[
	lib/libpanel/(
		_deck.c above.c below.c bottom.c del.c getuser.c hidden.c hide.c move.c
		new.c replace.c setuser.c show.c top.c update.c window.c
	)
	libcurses.a.d
]])
file('lib/libpanel.a', '644', '$outdir/libpanel.a')

exe('infocmp', [[usr.bin/infocmp/infocmp.c libterminfo.a]])
file('bin/infocmp', '755', '$outdir/infocmp')
exe('tabs', [[usr.bin/tabs/tabs.c libterminfo.a]])
file('bin/tabs', '755', '$outdir/tabs')
exe('tic', [[usr.bin/tic/tic.c compat/cdbw.c libterminfo.a]])
file('bin/tic', '755', '$outdir/tic')
exe('tput', [[usr.bin/tput/tput.c libterminfo.a]])
file('bin/tput', '755', '$outdir/tput')
exe('tset',  [[usr.bin/tset/(map.c misc.c set.c term.c tset.c) libterminfo.a]])
file('bin/tset', '755', '$outdir/tset')
sym('bin/reset', 'tset')

man{
	'usr.bin/infocmp/infocmp.1',
	'usr.bin/tabs/tabs.1',
	'usr.bin/tic/tic.1',
	'usr.bin/tput/tput.1',
	'usr.bin/tset/tset.1',
}

fetch 'git'
