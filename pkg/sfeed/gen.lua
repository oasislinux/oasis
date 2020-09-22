cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
}

lib('libutil.a', {'util.c', 'xml.c'})

local tools = {
	'sfeed',
	'sfeed_opml_import',
	'sfeed_plain',
	'sfeed_web',
	'sfeed_xmlenc',
}
for _, tool in ipairs(tools) do
	exe(tool, {tool..'.c', 'libutil.a'})
	file('bin/'..tool, '755', '$outdir/'..tool)
	man{tool..'.1'}
end

local scripts = {
	'sfeed_update',
	'sfeed_opml_export',
}
for _, script in ipairs(scripts) do
	file('bin/'..script, '755', '$srcdir/'..script)
	man{script..'.1'}
end

man{'sfeedrc.5'}

fetch 'git'
