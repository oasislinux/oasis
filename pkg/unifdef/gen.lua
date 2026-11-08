cflags{
	'-std=gnu99',
	'-I $dir',
}
exe('unifdef', {'unifdef.c'})
file('bin/unifdef', '755', '$outdir/unifdef')
file('bin/unifdefall', '755', '$srcdir/unifdefall.sh')
man{'unifdef.1'}
sym('share/man/man1/unifdefall.1.gz', 'unifdef.1.gz')

fetch 'curl'
