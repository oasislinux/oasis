cflags{
	'-std=c99',
	'-Wpedantic', '-Wall',
}

exe('pdpmake', {
	'check.c',
	'input.c',
	'macro.c',
	'main.c',
	'make.c',
	'modtime.c',
	'rules.c',
	'target.c',
	'utils.c',
})

file('bin/pdpmake', '755', '$outdir/pdpmake')

man{'pdpmake.1'}

fetch 'git'
