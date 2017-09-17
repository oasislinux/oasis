cflags{'-Wall', '-Wextra', '-I $dir'}

file('bin/sinit', '755', exe('sinit', {'sinit.c'}))
man{'sinit.8'}

fetch'git'
