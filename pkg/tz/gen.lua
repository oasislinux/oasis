cflags{'-I $dir'}

exe('zic', {'zic.c'})

rule('zic', 'zic -d $outdir/zoneinfo $in')
file('bin/zic', '755', '$outdir/zic')

local tzdata = {
	'africa',
	'antarctica',
	'asia',
	'australasia',
	'europe',
	'northamerica',
	'southamerica',
	'pacificnew',
	'etcetera',
	'backward',
	'systemv',
	'factory',
}
rule('tzdata', 'lua $dir/tzdata.lua $repo $outdir/zoneinfo $in >$out.tmp && mv $out.tmp $out')
build('tzdata', '$outdir/tzdata.index', {
	expand{'$srcdir/', tzdata},
	'|', '$dir/tzdata.lua', 'scripts/hash.rc',
	'||', '$builddir/root.stamp',
})
table.insert(pkg.inputs.index, '$outdir/tzdata.index')

fetch 'git'
