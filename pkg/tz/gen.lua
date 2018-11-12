cflags{'-I $dir'}

exe('zic', {'zic.c'})
file('bin/zic', '755', '$outdir/zic')
man{'zic.8'}

local tzdata = {
	'africa',
	'antarctica',
	'asia',
	'australasia',
	'europe',
	'northamerica',
	'southamerica',
	'etcetera',
	'systemv',
	'factory',
}
rule('tzdata', 'lua5.2 $dir/tzdata.lua $repo $outdir/zoneinfo $in >$out.tmp && mv $out.tmp $out')
build('tzdata', '$outdir/tzdata.index', {
	expand{'$srcdir/', tzdata},
	'|', '$dir/tzdata.lua', 'scripts/hash.sh',
	'||', '$builddir/root.stamp',
})
table.insert(pkg.inputs.index, '$outdir/tzdata.index')

fetch 'git'
