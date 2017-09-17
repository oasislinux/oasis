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
build('awk', '$outdir/tzdata.index', {
	expand{'$srcdir/', tzdata},
	'|', 'scripts/hash.rc', '$dir/tzdata.awk',
	'||', '$builddir/root.stamp',
}, {expr='-f $dir/tzdata.awk out=$outdir/zoneinfo repo=$repo'})
table.insert(pkg.inputs.index, '$outdir/tzdata.index')

fetch 'git'
