set('ninja_required_version', '1.8')

set('basedir', '.')
set('builddir', config.builddir)
set('outdir', '$builddir')

set('target_toolchain', config.target.toolchain)
set('target_cflags', config.target.cflags)
set('target_ldflags', config.target.ldflags)

set('host_toolchain', config.host.toolchain)
set('host_cflags', config.host.cflags)
set('host_ldflags', config.host.ldflags)

set('repo', config.repo.path)
set('repo_flags', config.repo.flags)
set('repo_tag', config.repo.tag)
set('repo_branch', config.repo.branch)

include 'rules.ninja'

toolchain 'target'

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
