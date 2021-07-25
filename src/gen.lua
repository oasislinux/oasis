set('srcdir', '$dir')
cflags{
	'-std=c11', '-Wall', '-Wextra', '-Wpedantic', '-Wno-unused-parameter',
}

file('libexec/applyperms',   '755', exe('applyperms',   {'applyperms.c'}))
file('libexec/mergeperms',   '755', exe('mergeperms',   {'mergeperms.c'}))
