cflags{
	'-std=c11', '-Wall', '-Wpedantic',
	'-D _POSIX_C_SOURCE=200809L',
	'-I $builddir/pkg/bearssl/include',
}

pkg.deps = {
	'pkg/bearssl/headers',
}

lib('libcommon.a', {
	'base16.c',
	'base64.c',
	'dnssec.c',
	'key.c',
	'zone.c',
})

for _, tool in ipairs{'ds', 'dnskey', 'nsec', 'rrsig'} do
	exe('dnssec-'..tool, {tool..'.c', 'libcommon.a', '$builddir/pkg/bearssl/libbearssl.a'})
	file('bin/dnssec-'..tool, '755', '$outdir/dnssec-'..tool)
end

fetch 'git'
