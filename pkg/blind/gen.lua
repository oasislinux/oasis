cflags{
	'-std=c99', '-Wall', '-pedantic',
	'-D _DEFAULT_SOURCE',
	'-D HAVE_PRCTL',
	'-D HAVE_EPOLL',
}

local cmds = {
	'blind-arithm',
	'blind-colour-ciexyz',
	'blind-colour-srgb',
	'blind-compress',
	'blind-concat',
	'blind-crop',
	'blind-cut',
	'blind-decompress',
	'blind-dissolve',
	'blind-extend',
	'blind-flip',
	'blind-flop',
	'blind-from-image',
	'blind-from-text',
	'blind-from-video',
	'blind-gauss-blur',
	'blind-invert-luma',
	'blind-next-frame',
	'blind-read-head',
	'blind-repeat',
	'blind-reverse',
	'blind-rewrite-head',
	'blind-set-alpha',
	'blind-set-luma',
	'blind-set-saturation',
	'blind-single-colour',
	'blind-skip-pattern',
	'blind-split',
	'blind-stack',
	'blind-time-blur',
	'blind-to-image',
	'blind-to-text',
	'blind-to-video',
	'blind-translate',
	'blind-transpose',
	'blind-write-head',
}
local scripts = {
	'blind-rotate-90',
	'blind-rotate-180',
	'blind-rotate-270',
}

lib('libutil.a', {'src/util.c', 'src/stream.c'})

for _, cmd in ipairs(cmds) do
	exe(cmd, {'src/'..cmd..'.c', 'libutil.a'})
	file('bin/'..cmd, '755', '$outdir/'..cmd)
end
for _, script in ipairs(scripts) do
	file('bin/'..script, '755', '$srcdir/'..script)
end

man(expand{'man/', {expand{{cmds, scripts}, '.1'}, 'blind.7'}})

fetch 'git'
