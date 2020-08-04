cflags{
	'-std=c99',
	'-D _XOPEN_SOURCE=700',
	'-I $outdir',
	'-I $srcdir',
}

yacc('awkgram', 'awkgram.y')

pkg.deps = {'$outdir/awkgram.tab.h'}

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{'-I $outdir'}
	exe('maketab', {'maketab.c'})
end)

rule('maketab', '$outdir/maketab $in >$out')
build('maketab', '$outdir/proctab.c', {'$outdir/ytab.h', '|', '$outdir/maketab'})

exe('awk', [[
	b.c main.c parse.c tran.c lib.c run.c lex.c
	$outdir/(awkgram.tab.c proctab.c)
]])
file('bin/awk', '755', '$outdir/awk')
man{'awk.1'}

fetch 'git'
