rule('versionhdr', 'sh $srcdir/version.sh --cwd=$srcdir --versionh=$out')
build('versionhdr', '$outdir/version.h', {'|', '$srcdir/version.sh'})

sub('tools.ninja', function()
	toolchain 'host'
	set('srcdir', '$dir')
	exe('file2string', {'file2string.c'})
end)

cflags{
	'-D _GNU_SOURCE',
	'-I $dir',
	'-I $outdir',
	'-I $srcdir',
	'-I pkg/ffmpeg/src',
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

rule('file2string', '$outdir/file2string $in >$out.tmp && mv $out.tmp $out')
function file2string(out, inp)
	build('file2string', '$outdir/'..out, {'$srcdir/'..inp, '|', '$outdir/file2string'})
	table.insert(pkg.deps, '$outdir/'..out)
end

file2string('input/input_conf.h', 'etc/input.conf')
file2string('player/builtin_conf.inc', 'etc/builtin.conf')
file2string('sub/osd_font.h', 'sub/osd_font.otf')
for _, f in ipairs{'assdraw', 'defaults', 'options', 'osc', 'ytdl_hook'} do
	file2string('player/lua/'..f..'.inc', 'player/lua/'..f..'.lua')
end

local options = {}
for line in io.lines(pkg.dir..'/config.h') do
	local var, val = line:match('^#define ([^ ]+) ([^ ]+)')
	if var and val == '1' then
		options[var] = true
	end
end
local sources = {}
for line in io.lines(pkg.dir..'/sources.txt') do
	local i = line:find(' ', 1, true)
	local add = true
	if i then
		local var = line:sub(i + 1):upper():gsub('-', '_')
		local neg = var:sub(1, 1) == '!'
		if neg then
			var = var:sub(2)
		end
		add = options['HAVE_'..var] or false ~= neg
	end
	if add then
		sources[line:sub(1, i and i - 1)] = true
	end
end
sources = table.keys(sources)
table.insert(pkg.inputs.gen, {'$dir/config.h', '$dir/sources.txt'})

if options['HAVE_ALSA'] then
	cflags{'-I $builddir/pkg/alsa-lib/include'}
	table.insert(libs, 'alsa-lib/libasound.a')
	table.insert(pkg.deps, 'pkg/alsa-lib/headers')
end
if options['HAVE_DRM'] then
	cflags{
		'-I pkg/libdrm/src',
		'-I pkg/libdrm/src/include/drm',
	}
	table.insert(libs, 'libdrm/libdrm.a')
	table.insert(pkg.deps, 'pkg/libdrm/fetch')
end
if options['HAVE_LIBASS'] then
	cflags{'-I $builddir/pkg/libass/include'}
	table.insert(libs, 'libass/libass.a.d')
	table.insert(pkg.deps, 'pkg/libass/headers')
end
if options['HAVE_LUA'] then
	cflags{'-I pkg/lua/src/src'}
	table.insert(libs, 'lua/liblua.a')
	table.insert(pkg.deps, 'pkg/lua/fetch')
end
if options['HAVE_WAYLAND'] then
	cflags{
		'-I $builddir/pkg/wayland/include',
		'-I pkg/libxkbcommon/src',
	}
	table.insert(libs, {
		'wayland/libwayland-client.a.d',
		'wayland/libwayland-cursor.a.d',
		'libxkbcommon/libxkbcommon.a',
	})
	table.insert(pkg.deps, {
		'pkg/wayland/headers',
		'pkg/libxkbcommon/fetch',
	})
end

exe('mpv', {
	'ta/ta.c',
	'ta/ta_talloc.c',
	'ta/ta_utils.c',
	sources,
	expand{'$builddir/pkg/', libs},
})
file('bin/mpv', '755', '$outdir/mpv')
man{'$dir/mpv.1'}

fetch 'git'
