local fonts = {
	'SourceCodePro-Black',
	'SourceCodePro-BlackIt',
	'SourceCodePro-Bold',
	'SourceCodePro-BoldIt',
	'SourceCodePro-ExtraLight',
	'SourceCodePro-ExtraLightIt',
	'SourceCodePro-It',
	'SourceCodePro-Light',
	'SourceCodePro-LightIt',
	'SourceCodePro-Medium',
	'SourceCodePro-MediumIt',
	'SourceCodePro-Regular',
	'SourceCodePro-Semibold',
	'SourceCodePro-SemiboldIt',

	'SourceSans3-Black',
	'SourceSans3-BlackIt',
	'SourceSans3-Bold',
	'SourceSans3-BoldIt',
	'SourceSans3-ExtraLight',
	'SourceSans3-ExtraLightIt',
	'SourceSans3-It',
	'SourceSans3-Light',
	'SourceSans3-LightIt',
	'SourceSans3-Regular',
	'SourceSans3-Semibold',
	'SourceSans3-SemiboldIt',

	'SourceSerif4-Black',
	'SourceSerif4-BlackIt',
	'SourceSerif4-Bold',
	'SourceSerif4-BoldIt',
	'SourceSerif4-ExtraLight',
	'SourceSerif4-ExtraLightIt',
	'SourceSerif4-It',
	'SourceSerif4-Light',
	'SourceSerif4-LightIt',
	'SourceSerif4-Regular',
	'SourceSerif4-Semibold',
	'SourceSerif4-SemiboldIt',
}

for _, font in ipairs(fonts) do
	local path = ('share/fonts/%s.otf'):format(font)
	local src = ('$srcdir/OTF/%s.otf'):format(font)
	file(path, '644', src)
end

fetch 'curl'
