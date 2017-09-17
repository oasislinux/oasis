local function font(name, styles)
	for _, style in ipairs(styles) do
		local path = string.format('share/fonts/%s/%s.otf', name, style)
		local src = string.format('$srcdir/OTF/%s.otf', style)
		file(path, '644', src)
	end
end

font('source-code-pro', {
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
})

font('source-sans-pro', {
	'SourceSansPro-Black',
	'SourceSansPro-BlackIt',
	'SourceSansPro-Bold',
	'SourceSansPro-BoldIt',
	'SourceSansPro-ExtraLight',
	'SourceSansPro-ExtraLightIt',
	'SourceSansPro-It',
	'SourceSansPro-Light',
	'SourceSansPro-LightIt',
	'SourceSansPro-Regular',
	'SourceSansPro-Semibold',
	'SourceSansPro-SemiboldIt',
})

font('source-serif-pro', {
	'SourceSerifPro-Black',
	'SourceSerifPro-Bold',
	'SourceSerifPro-ExtraLight',
	'SourceSerifPro-Light',
	'SourceSerifPro-Regular',
	'SourceSerifPro-Semibold',
})

fetch 'curl'
