toolchain 'target'

subgen 'pkg'
subgen 'src'

file('.perms', '644', '$outdir/root.perms')

build('gitinit', '$builddir/root.stamp')
build('gittree', '$builddir/root.tree', {'$outdir/root.index', '|', 'scripts/tree.rc', '||', '$builddir/root.stamp'})
build('gitarchive', '$builddir/root.tar', {'|', '$builddir/root.tree'})
build('gitcommit', '$builddir/root.commit', {'|', '$builddir/root.tree'})
build('phony', 'commit', {'$builddir/root.commit'})

io.write('default $builddir/root.tree\n')
