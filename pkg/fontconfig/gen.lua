cflags{
	'-D HAVE_CONFIG_H',
	'-I include',
	'-I $dir',
	'-I $outdir',
	'-I $srcdir',
	'-I pkg/freetype/src/include',
	'-I $builddir/pkg/expat/include',
}

pkg.deps = {
	'pkg/expat/headers',
	'pkg/freetype/fetch',
}

rule('makealias', '$srcdir/src/makealias $srcdir/src $out $in')
local function makealias(name, srcs)
	local outs = {'$outdir/'..name..'.h', '$outdir/'..name..'tail.h'}
	table.insert(pkg.deps, outs)
	build('makealias', outs, {expand{'$srcdir/', srcs}, '|', '$srcdir/src/makealias'})
end

makealias('fcalias', {
	'fontconfig/fontconfig.h',
	'fontconfig/fcprivate.h',
	'src/fcdeprecate.h',
})
makealias('fcftalias', 'fontconfig/fcfreetype.h')

lib('libfontconfig.a', [[
	src/(
		fcatomic.c
		fcblanks.c
		fccache.c
		fccfg.c
		fccharset.c
		fccompat.c
		fcdbg.c
		fcdefault.c
		fcdir.c
		fcformat.c
		fcfreetype.c
		fcfs.c
		fcinit.c
		fclang.c
		fclist.c
		fcmatch.c
		fcmatrix.c
		fcname.c
		fcobjs.c
		fcpat.c
		fcrange.c
		fcserialize.c
		fcstat.c
		fcstr.c
		fcweight.c
		fcxml.c
		ftglue.c
	)
	$builddir/pkg/(
		expat/libexpat.a.d
		freetype/libfreetype.a.d
	)
]])

fetch 'curl'
