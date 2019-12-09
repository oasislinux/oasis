cflags{
	'-D NDEBUG',
	'-D VERSION=2.4.0',
	'-D _POSIX_C_SOURCE=200809L',
	'-I $srcdir/include',
	'-include $dir/config.h',
}

sub('tools.ninja', function()
	exe('strgen', {'gen/strgen.c'})
	rule('strgen', [[$outdir/strgen $in $out $name $header '$label' '$define' $removetabs]])
	build('strgen', '$outdir/bc_help.c', {'$srcdir/gen/bc_help.txt', '|', '$outdir/strgen'}, {
		name='bc_help', header='bc.h', label='', define='BC_ENABLED', removetabs='',
	})
	build('strgen', '$outdir/dc_help.c', {'$srcdir/gen/dc_help.txt', '|', '$outdir/strgen'}, {
		name='dc_help', header='dc.h', label='', define='DC_ENABLED', removetabs='',
	})
	build('strgen', '$outdir/lib.c', {'$srcdir/gen/lib.bc', '|', '$outdir/strgen'}, {
		name='bc_lib', header='bc.h', label='bc_lib_name', define='BC_ENABLED', removetabs='1',
	})
	build('strgen', '$outdir/lib2.c', {'$srcdir/gen/lib2.bc', '|', '$outdir/strgen'}, {
		name='bc_lib2', header='bc.h', label='bc_lib2_name', define='BC_ENABLED && BC_ENABLE_EXTRA_MATH', removetabs='1',
	})
end)

exe('bin/bc', [[
	src/(
		args.c
		data.c
		lang.c
		lex.c
		main.c
		num.c
		parse.c
		program.c
		read.c
		vector.c
		vm.c
		bc/(bc.c lex.c parse.c)
		dc/(dc.c lex.c parse.c)
		history/history.c
	)
	$outdir/(bc_help.c dc_help.c lib.c lib2.c)
]])
file('bin/bc', '755', '$outdir/bin/bc')
man{'manuals/bc.1'}

fetch 'git'
