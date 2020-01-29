cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $outdir',
	'-I $outdir/include',
	'-I $srcdir/lib',
}

sub('tools.ninja', function()
	toolchain 'host'
	cflags{
		'-D HAVE_STRINGIZE',
		'-D DONT_HAVE_FRIBIDI_CONFIG_H',
		'-D HAVE_STDLIB_H',
		'-D HAVE_STRING_H',
		'-D HAVE_STRINGS_H',
		'-D STDC_HEADERS',
		'-I $outdir/include',
		'-I $srcdir/lib',
	}
	cc('gen.tab/packtab.c')
	exe('gen-unicode-version', {'gen.tab/gen-unicode-version.c'})
	for _, t in ipairs{'arabic-shaping', 'bidi-type', 'joining-type', 'mirroring', 'brackets', 'brackets-type'} do
		exe('gen-'..t..'-tab', expand{'gen.tab/', {
			'gen-'..t..'-tab.c',
			'packtab.c.o',
		}}, {'$gendir/headers'})
	end
end)

set('compression', '2')

rule('gentool', '$outdir/$tool $args $in >$out')
local function gentool(tool, out, srcs, args)
	build('gentool', '$outdir/'..out, {expand{'$srcdir/gen.tab/unidata/', srcs}, '|', '$outdir/gen-'..tool}, {
		tool='gen-'..tool,
		args=args,
	})
end

gentool('unicode-version', 'include/fribidi-unicode-version.h', {'BidiMirroring.txt'})
gentool('arabic-shaping-tab', 'arabic-shaping.tab.i', {'UnicodeData.txt'}, '$compression')
gentool('bidi-type-tab', 'bidi-type.tab.i', {'UnicodeData.txt'}, '$compression')
gentool('joining-type-tab', 'joining-type.tab.i', {'UnicodeData.txt', 'ArabicShaping.txt'}, '$compression')
gentool('mirroring-tab', 'mirroring.tab.i', {'BidiMirroring.txt'}, '$compression')
gentool('brackets-tab', 'brackets.tab.i', {'BidiBrackets.txt', 'UnicodeData.txt'}, '$compression')
gentool('brackets-type-tab', 'brackets-type.tab.i', {'BidiBrackets.txt'}, '$compression')

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/lib', {
		'fribidi-arabic.h',
		'fribidi-begindecls.h',
		'fribidi-bidi.h',
		'fribidi-bidi-types.h',
		'fribidi-bidi-types-list.h',
		'fribidi-common.h',
		'fribidi-char-sets.h',
		'fribidi-char-sets-list.h',
		'fribidi-deprecated.h',
		'fribidi-enddecls.h',
		'fribidi-flags.h',
		'fribidi-joining.h',
		'fribidi-joining-types.h',
		'fribidi-joining-types-list.h',
		'fribidi-mirroring.h',
		'fribidi-brackets.h',
		'fribidi-shape.h',
		'fribidi-types.h',
		'fribidi-unicode.h',
		'fribidi.h',
	}),
	copy('$outdir/include', '$dir', {'fribidi-config.h'}),
	'$outdir/include/fribidi-unicode-version.h',
}
pkg.deps = {
	'$outdir/bidi-type.tab.i',
	'$outdir/joining-type.tab.i',
	'$outdir/arabic-shaping.tab.i',
	'$outdir/mirroring.tab.i',
	'$outdir/brackets.tab.i',
	'$outdir/brackets-type.tab.i',
	'$gendir/headers',
}

lib('libfribidi.a', [[
	lib/(
		fribidi.c
		fribidi-arabic.c
		fribidi-bidi.c
		fribidi-bidi-types.c
		fribidi-deprecated.c
		fribidi-char-sets.c
		fribidi-char-sets-cap-rtl.c
		fribidi-char-sets-cp1255.c
		fribidi-char-sets-cp1256.c
		fribidi-char-sets-iso8859-6.c
		fribidi-char-sets-iso8859-8.c
		fribidi-char-sets-utf8.c
		fribidi-joining.c
		fribidi-joining-types.c
		fribidi-mirroring.c
		fribidi-brackets.c
		fribidi-run.c
		fribidi-shape.c
	)
]])

fetch 'git'
