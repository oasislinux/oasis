build('awk', '$outdir/version.h', {'$srcdir/VERSION', '|', '$dir/version.awk'}, {
	expr='-f $dir/version.awk',
})

sub('tools.ninja', function()
	toolchain 'host'
	set('srcdir', '$dir')
	exe('file2string', {'file2string.c'})
end)

cflags{
	'-Wno-deprecated-declarations',
	'-D _GNU_SOURCE',
	'-I $dir',
	'-I $outdir',
	'-I $srcdir',
	'-I $basedir/pkg/ffmpeg/src',
	'-I $builddir/pkg/ffmpeg/include',
	'-I $builddir/pkg/zlib/include',
}
local libs = {
	'ffmpeg/libavcodec.a.d',
	'ffmpeg/libavdevice.a.d',
	'ffmpeg/libavfilter.a.d',
	'ffmpeg/libavformat.a.d',
	'ffmpeg/libavutil.a',
	'ffmpeg/libswresample.a.d',
	'ffmpeg/libswscale.a.d',
	'zlib/libz.a',
}
pkg.deps = {
	'$outdir/version.h',
	'pkg/ffmpeg/headers',
	'pkg/zlib/headers',
}

build('copy', '$outdir/video/out/wayland/idle-inhibit-v1.h', '$builddir/pkg/wayland-protocols/include/idle-inhibit-unstable-v1-client-protocol.h')
build('copy', '$outdir/video/out/wayland/presentation-time.h', '$builddir/pkg/wayland-protocols/include/presentation-time-client-protocol.h')
build('copy', '$outdir/video/out/wayland/xdg-decoration-v1.h', '$builddir/pkg/wayland-protocols/include/xdg-decoration-unstable-v1-client-protocol.h')
build('copy', '$outdir/video/out/wayland/xdg-shell.h', '$builddir/pkg/wayland-protocols/include/xdg-shell-client-protocol.h')

rule('file2string', '$outdir/file2string $in >$out')
local function file2string(out, inp)
	build('file2string', '$outdir/'..out, {'$srcdir/'..inp, '|', '$outdir/file2string'})
	table.insert(pkg.deps, '$outdir/'..out)
end

file2string('input/input_conf.h', 'etc/input.conf')
file2string('player/builtin_conf.inc', 'etc/builtin.conf')
file2string('sub/osd_font.h', 'sub/osd_font.otf')
for _, f in ipairs{'defaults', 'assdraw', 'options', 'osc', 'ytdl_hook', 'stats', 'console'} do
	file2string('player/lua/'..f..'.inc', 'player/lua/'..f..'.lua')
end

local options = {}
for line in iterlines('config.h', 1) do
	local var, val = line:match('^#define ([^ ]+) ([^ ]+)')
	if var and val == '1' then
		options[var] = true
	end
end
table.insert(pkg.inputs.gen, '$dir/config.h')

-- source inclusion parser
local eval
do
	local ops = {
		{tok='||', fn=function(a, b) return a or b end, binary=true},
		{tok='&&', fn=function(a, b) return a and b end, binary=true},
		{tok='!', fn=function(a) return not a end},
	}
	local function check(x)
		if not x then
			error('invalid expression')
		end
	end
	local function helper(s, i, j)
		local result, var, val
		if s:sub(i, i) == '(' then
			i = s:find('[^%s]', i + 1)
			check(i)
			result, i = parse(s, i, 1)
			check(i and s:sub(i, i) == ')')
			return result, s:find('[^%s]', i + 1)
		end
		if j > #ops then
			local k = select(2, s:find('^[%w_.-]+', i))
			check(k)
			var = s:sub(i, k):upper():gsub('-', '_')
			i = s:find('[^%s]', k + 1)
			return options['HAVE_'..var] or false, i
		end
		local op = ops[j]
		if op.binary then
			result, i = helper(s, i, j + 1)
		end
		if i and s:sub(i, i + #op.tok - 1) == op.tok then
			i = s:find('[^%s]', i + #op.tok)
			check(i)
			val, i = helper(s, i, j)
			result = op.fn(val, result)
		elseif not op.binary then
			result, i = helper(s, i, j + 1)
		end
		return result, i
	end
	eval = function(s, i)
		result, i = helper(s, i, 1)
		check(not i)
		return result
	end
end

local sources = {}
for line in iterlines('sources.txt', 1) do
	local i = line:find(' ', 1, true)
	local add = true
	if not i or eval(line, i + 1) then
		sources[line:sub(1, i and i - 1)] = true
	end
end
sources = table.keys(sources)

if options['HAVE_ALSA'] then
	cflags{'-I $builddir/pkg/alsa-lib/include'}
	table.insert(libs, 'alsa-lib/libasound.a')
	table.insert(pkg.deps, 'pkg/alsa-lib/headers')
end
if options['HAVE_DRM'] then
	cflags{'-I $builddir/pkg/libdrm/include'}
	table.insert(libs, 'libdrm/libdrm.a')
	table.insert(pkg.deps, 'pkg/libdrm/headers')
end
if options['HAVE_LIBASS'] then
	cflags{'-I $builddir/pkg/libass/include'}
	table.insert(libs, 'libass/libass.a.d')
	table.insert(pkg.deps, 'pkg/libass/headers')
end
if options['HAVE_LUA'] then
	cflags{'-I $basedir/pkg/lua/src/src'}
	table.insert(libs, 'lua/liblua.a')
	table.insert(pkg.deps, 'pkg/lua/fetch')
end
if options['HAVE_WAYLAND'] then
	cflags{
		'-I $builddir/pkg/wayland/include',
		'-I $basedir/pkg/libxkbcommon/src',
	}
	table.insert(libs, {
		'wayland/libwayland-client.a.d',
		'wayland/libwayland-cursor.a.d',
		'libxkbcommon/libxkbcommon.a',
	})
	table.insert(pkg.deps, {
		'$outdir/video/out/wayland/idle-inhibit-v1.h',
		'$outdir/video/out/wayland/presentation-time.h',
		'$outdir/video/out/wayland/xdg-decoration-v1.h',
		'$outdir/video/out/wayland/xdg-shell.h',
		'pkg/wayland/headers',
		'pkg/libxkbcommon/fetch',
	})
end

exe('mpv', {
	'input/ipc-unix.c',
	'osdep/main-fn-unix.c',
	'osdep/subprocess-posix.c',
	'osdep/terminal-unix.c',
	'osdep/timer-linux.c',
	'ta/ta.c',
	'ta/ta_talloc.c',
	'ta/ta_utils.c',
	sources,
	expand{'$builddir/pkg/', libs},
})
file('bin/mpv', '755', '$outdir/mpv')
man{'$dir/mpv.1'}

fetch 'git'
