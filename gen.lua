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

build('awk', '$outdir/root.perms', {'$outdir/root.fspec', '|', '$basedir/scripts/perms.awk'}, {
	expr='-f $basedir/scripts/perms.awk',
})
gitfile('.perms', '644', '$outdir/root.perms')

build('git-init', '$outdir/root.stamp')
build('git-tree', '$outdir/root.tree', {'$outdir/root.index', '|', '$basedir/scripts/tree.sh', '||', '$outdir/root.stamp'})
build('git-archive', '$outdir/root.tar', {'|', '$outdir/root.tree'})
build('git-commit', '$outdir/root.commit', {'|', '$outdir/root.tree'})
build('phony', 'commit', '$builddir/root.commit')
build('phony', 'build.ninja', 'ninja', {generator='1'})

io.write('default $builddir/root.tree\n')
