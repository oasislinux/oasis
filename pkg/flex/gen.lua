cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
}

exe('flex', [[src/(
	buf.c
	ccl.c
	dfa.c
	ecs.c
	filter.c
	gen.c
	main.c
	misc.c
	nfa.c
	options.c
	parse.c
	regex.c
	scan.c
	scanflags.c
	scanopt.c
	skel.c
	sym.c
	tables.c
	tables_shared.c
	tblcmp.c
	yylex.c
)]])
file('bin/flex', '755', '$outdir/flex')
sym('bin/lex', 'flex')
man{'doc/flex.1'}

fetch 'curl'
