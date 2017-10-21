set('builddir', config.builddir or 'out')
set('outdir', '$builddir')

set('target_toolchain', config.target_toolchain or 'x86_64-linux-musl')
set('target_cflags', config.target_cflags or '-O2 -pipe')
set('target_cxxflags', config.target_cxxflags or '$target_cflags')
set('target_ldflags', config.target_ldflags or '-s -static')

set('host_toolchain', config.host_toolchain or 'default')
set('host_cflags', config.host_cflags or '-pipe')
set('host_cxxflags', config.host_cxxflags or '$host_cflags')
set('host_ldflags', config.host_ldflags or '')

set('repo', config.repo or '$builddir/root.git')
set('repo_flags', config.repo_flags or '--bare')
set('repo_tag', config.repo_tag or 'tree')
set('repo_branch', config.repo_branch or 'master')

include 'rules.ninja'

toolchain 'target'

subgen 'pkg'
subgen 'src'

file('.perms', '644', '$outdir/root.perms')

build('gitinit', '$builddir/root.stamp')
build('gittree', '$builddir/root.tree', {'$outdir/root.index', '|', 'scripts/tree.rc', '||', '$builddir/root.stamp'})
build('gitarchive', '$builddir/root.tar', {'|', '$builddir/root.tree'})
build('gitcommit', '$builddir/root.commit', {'|', '$builddir/root.tree'})
build('phony', 'commit', '$builddir/root.commit')
build('phony', 'build.ninja', 'ninja', {generator='1'})

io.write('default $builddir/root.tree\n')
