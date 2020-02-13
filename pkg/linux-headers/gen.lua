local arch = ({
	aarch64='arm64',
	x86_64='x86',
})[config.target.platform:match('[^-]*')]
sub('tools.ninja', function()
	toolchain(config.host)
	exe('unifdef', {'scripts/unifdef.c'})
end)

rule('header', 'sed -E -f $dir/header.sed $in >$out.tmp && { $outdir/unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ $out.tmp >$out; [ $$? -le 1 ]; } && rm $out.tmp')
rule('wrapper', [[printf '#include <asm-generic/%s>\n' $file >$out]])

local function process(outdir, srcdir, files)
	local outs = {}
	for i, file in ipairs(files) do
		local out = outdir..'/'..file
		outs[i] = out
		build('header', out, {srcdir..'/'..file, '|', '$dir/header.sed', '$outdir/unifdef'})
	end
	return outs
end

local mandatory = {
	-- <awk '$1 == "mandatory-y" {printf "\\t'\'%s\'',\\n", $3}' src/include/uapi/asm-generic/Kbuild
	'auxvec.h',
	'bitsperlong.h',
	'bpf_perf_event.h',
	'byteorder.h',
	'errno.h',
	'fcntl.h',
	'ioctl.h',
	'ioctls.h',
	'ipcbuf.h',
	'mman.h',
	'msgbuf.h',
	'param.h',
	'poll.h',
	'posix_types.h',
	'ptrace.h',
	'resource.h',
	'sembuf.h',
	'setup.h',
	'shmbuf.h',
	'sigcontext.h',
	'siginfo.h',
	'signal.h',
	'socket.h',
	'sockios.h',
	'stat.h',
	'statfs.h',
	'swab.h',
	'termbits.h',
	'termios.h',
	'types.h',
	'unistd.h',
}

local basefiles = load('base.lua')
local archfiles = load(arch..'.lua')

build('awk', '$outdir/include/linux/version.h', {'$srcdir/Makefile', '|', '$dir/version.awk'}, {
	expr='-f $dir/version.awk',
})

pkg.hdrs = {
	'$outdir/include/linux/version.h',
	process('$outdir/include', '$srcdir/include/uapi', basefiles),
	process('$outdir/include', '$srcdir/arch/'..arch..'/include/uapi', archfiles),
	install=true,
}

for _, file in ipairs(archfiles) do
	archfiles[file] = true
end
for _, file in ipairs(mandatory) do
	if not archfiles['asm/'..file] then
		local out = '$outdir/include/asm/'..file
		build('wrapper', out, nil, {file=file})
		table.insert(pkg.hdrs, out)
	end
end

for _, spec in ipairs(archfiles.unistd) do
	local out = '$outdir/include/asm/'..spec.dst
	build('awk', out, {'$srcdir/'..spec.src, '|', '$dir/unistd.awk'}, {
		expr={
			'-v arch='..arch,
			'-v file='..spec.dst,
			string.format([[-v abi='%s']], spec.abi),
			'-v off='..(spec.off or ''),
			'-f $dir/unistd.awk',
		},
	})
	table.insert(pkg.hdrs, out)
end

fetch 'local'
