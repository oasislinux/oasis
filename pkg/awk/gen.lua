cflags{
	'-std=c90',
	'-D _POSIX_C_SOURCE=200809L',
	'-I $outdir',
	'-I $srcdir',
}

yacc('gram', 'awkgram.y')
build('copy', '$outdir/ytab.h', '$outdir/gram.tab.h')

pkg.deps = {'$outdir/ytab.h'}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'-I $outdir'}
	exe('maketab', {'maketab.c'})
end)

rule('maketab', '$outdir/maketab $in >$out.tmp && mv $out.tmp $out')
build('maketab', '$outdir/proctab.c', {'$outdir/ytab.h', '|', '$outdir/maketab'})

exe('awk', [[
	b.c main.c parse.c tran.c lib.c run.c lex.c
	$outdir/(gram.tab.c proctab.c)
]])
file('bin/awk', '755', '$outdir/awk')
man{'awk.1'}

fetch 'git'
