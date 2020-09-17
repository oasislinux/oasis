cflags{
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic', '-Wno-switch',
	'-D _XOPEN_SOURCE=700',
}

lib('libcommon.a', {
	'blaze822.c',
	'filter.c',
	'mymemmem.c',
	'mystrverscmp.c',
	'mytimegm.c',
	'pipeto.c',
	'rfc2045.c',
	'rfc2047.c',
	'rfc2231.c',
	'safe_u8putstr.c',
	'seq.c',
	'slurp.c',
	'squeeze_slash.c',
})

local tools = {
	'maddr',
	'magrep',
	'mdate',
	'mdeliver',
	'mdirs',
	'mexport',
	'mflag',
	'mflow',
	'mgenmid',
	'mhdr',
	'minc',
	'mlist',
	'mmime',
	'mpick',
	'mscan',
	'msed',
	'mseq',
	'mshow',
	'msort',
	'mthread',
}
for _, tool in ipairs(tools) do
	exe(tool, {tool..'.c', 'libcommon.a'})
	file('bin/'..tool, '755', '$outdir/'..tool)
end

build('awk', '$outdir/museragent', {'$srcdir/VERSION'}, {
	expr=[['{print "#!/bin/sh"; print "exec printf \"User-Agent: mblaze/%s\\n\" \"" $$0 "\""}']],
})
	
local scripts = {
	'mcolor',
	'mcom',
	'mless',
	'mmkdir',
	'mquote',
}
for _, script in ipairs(scripts) do
	file('bin/'..script, '755', '$srcdir/'..script)
end
file('bin/museragent', '755', '$outdir/museragent')
sym('bin/mbnc', 'mcom')
sym('bin/mfwd', 'mcom')
sym('bin/mrep', 'mcom')

man{
	'man/maddr.1',
	'man/magrep.1',
	'man/mblaze-profile.5',
	'man/mblaze.7',
	'man/mbnc.1',
	'man/mcom.1',
	'man/mdeliver.1',
	'man/mdirs.1',
	'man/mexport.1',
	'man/mflag.1',
	'man/mflow.1',
	'man/mfwd.1',
	'man/mgenmid.1',
	'man/mhdr.1',
	'man/minc.1',
	'man/mless.1',
	'man/mlist.1',
	'man/mmime.1',
	'man/mmkdir.1',
	'man/mmsg.7',
	'man/mpick.1',
	'man/mrefile.1',
	'man/mrep.1',
	'man/mscan.1',
	'man/msed.1',
	'man/mseq.1',
	'man/mshow.1',
	'man/msort.1',
	'man/mthread.1',
}

fetch 'git'
