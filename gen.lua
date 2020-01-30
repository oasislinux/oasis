set('ninja_required_version', '1.8')

set('basedir', basedir)
set('builddir', config.builddir)
set('dir', '$basedir')
set('outdir', '$builddir')

set('repo', config.repo.path)
set('repo_flags', config.repo.flags)
set('repo_tag', config.repo.tag)
set('repo_branch', config.repo.branch)

include '$basedir/rules.ninja'

toolchain(config.target)

subgen 'probe'
subgen 'pkg'
subgen 'src'

file('.perms', '644', '$outdir/root.perms')

build('gitinit', '$builddir/root.stamp')
build('gittree', '$builddir/root.tree', {'$outdir/root.index', '|', '$basedir/scripts/tree.sh', '||', '$builddir/root.stamp'})
build('gitarchive', '$builddir/root.tar', {'|', '$builddir/root.tree'})
build('gitcommit', '$builddir/root.commit', {'|', '$builddir/root.tree'})
build('phony', 'commit', '$builddir/root.commit')
build('phony', 'build.ninja', 'ninja', {generator='1'})

io.write('default $builddir/root.tree\n')
