cflags{
	'-Wno-return-type', '-Wno-implicit-int',
	'-I $dir',
	'-I $srcdir',
	'-I $outdir',
}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{'-Wno-implicit-int', '-I $outdir'}
	exe('mktags', {'mktags.c'})
end)

rule('mktags', '$outdir/mktags >$out.tmp && mv $out.tmp $out')
build('mktags', '$outdir/blocktags', {'|', '$outdir/mktags'})

build('awk', '$outdir/version.c', '$srcdir/VERSION', {
	expr=[['{printf "char markdown_version[] = \"%s\";\n", $$0}']],
})
build('sed', '$outdir/mkdio.h', '$srcdir/mkdio.h.in', {
	expr={
		'-e \'4i#include <stdint.h>\'',
		'-e s,@DWORD@,uint32_t,',
	},
})

pkg.deps = {'$outdir/blocktags', '$outdir/mkdio.h'}

lib('libmarkdown.a', [[
	mkdio.c markdown.c dumptree.c generate.c
	resource.c docheader.c $outdir/version.c toc.c css.c
	xml.c Csio.c xmlpage.c basename.c emmatch.c
	github_flavoured.c setup.c tags.c html5.c flags.c
]])

exe('markdown', {'main.c', 'pgm_options.c', 'libmarkdown.a'})
file('bin/markdown', '755', '$outdir/markdown')
man{'markdown.1', 'markdown.7'}

fetch 'git'
