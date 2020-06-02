cflags{'-std=c99', '-Wall', '-Wpedantic'}

pkg.hdrs = copy('$outdir/include', '$srcdir', {'utf8proc.h'})

lib('libutf8proc.a', {'utf8proc.c'})

fetch 'git'
