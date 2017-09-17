cflags{
	'-D _GNU_SOURCE',
	'-I include',
	'-idirafter pkg/openbsd/src/sys',
}

cc('emacs.c', {'$builddir/pkg/openbsd/fetch.stamp'})
exe('ksh', {
	'alloc.c',
	'c_ksh.c',
	'c_sh.c',
	'c_test.c',
	'c_ulimit.c',
	'edit.c',
	'emacs.c.o',
	'eval.c',
	'exec.c',
	'expr.c',
	'history.c',
	'io.c',
	'jobs.c',
	'lex.c',
	'mail.c',
	'main.c',
	'misc.c',
	'path.c',
	'shf.c',
	'syn.c',
	'table.c',
	'trap.c',
	'tree.c',
	'tty.c',
	'var.c',
	'version.c',
	'vi.c',
})
file('bin/ksh', '755', '$outdir/ksh')
sym('bin/sh', 'ksh')
man{'ksh.1', 'sh.1'}

fetch 'git'
