cflags{
	'-D _GNU_SOURCE',
	'-D EMACS',
	'-D SMALL',
	'-D VI',
	'-I $dir',
}

exe('ksh', [[
	alloc.c asprintf.c c_ksh.c c_sh.c c_test.c c_ulimit.c edit.c
	emacs.c eval.c exec.c expr.c history.c io.c jobs.c lex.c mail.c
	main.c misc.c path.c shf.c syn.c table.c trap.c tree.c tty.c var.c
	version.c vi.c confstr.c reallocarray.c siglist.c signame.c
	strlcat.c strlcpy.c strtonum.c unvis.c vis.c issetugid.c
]])
file('bin/ksh', '755', '$outdir/ksh')
sym('bin/sh', 'ksh')
man{'ksh.1', 'sh.1'}

fetch 'git'
