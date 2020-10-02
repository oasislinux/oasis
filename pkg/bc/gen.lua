cflags{
	'-D NDEBUG',
	'-D VERSION=3.1.6',
	'-D _POSIX_C_SOURCE=200809L',
	'-I $srcdir/include',
	'-include $dir/config.h',
}

sub('tools.ninja', function()
	toolchain(config.host)
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
		file.c
		lang.c
		lex.c
		main.c
		num.c
		opt.c
		parse.c
		program.c
		read.c
		vector.c
		vm.c
		bc/(bc.c lex.c parse.c)
		dc/(dc.c lex.c parse.c)
		history/history.c
		rand/rand.c
	)
	$outdir/(bc_help.c dc_help.c lib.c lib2.c)
]])
file('bin/bc', '755', '$outdir/bin/bc')

local opts = {}
for line in iterlines('config.h', 1) do
	local var, val = line:match('^define ([^ ]+) ([^ ]+)')
	if var and val == '1' then
		opts[var] = true
	end
end

local manfile = ''
if not opts.BC_ENABLE_EXTRA_MATH then manfile = manfile..'E' end
if not opts.BC_ENABLE_HISTORY    then manfile = manfile..'H' end
if not opts.BC_ENABLE_NLS        then manfile = manfile..'N' end
if not opts.BC_ENABLE_PROMPT     then manfile = manfile..'P' end
if manfile == ''                 then manfile = 'A' end

build('copy', '$outdir/bc.1', '$srcdir/manuals/bc/'..manfile..'.1')
man{'$outdir/bc.1'}

fetch 'git'
