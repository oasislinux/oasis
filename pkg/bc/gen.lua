cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
	'-I $dir',
	'-I $srcdir/h',
}

exe('bin/bc', [[
	bc/(
		main.c bc.c scan.c execute.c load.c storage.c util.c global.c
		warranty.c
	)
	lib/number.c
]])
file('bin/bc', '755', '$outdir/bin/bc')
man{'doc/bc.1'}

fetch 'curl'
