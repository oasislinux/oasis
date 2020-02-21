cflags{'-std=c99', '-Wall', '-Wpedantic'}

lib('libutf8proc.a', {'utf8proc.c'})

fetch 'git'
