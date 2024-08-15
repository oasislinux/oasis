build('awk', '$outdir/version.h', {'$srcdir/VERSION', '|', '$dir/version.awk'}, {
	expr='-f $dir/version.awk',
})

sub('tools.ninja', function()
	toolchain(config.host)
	set('srcdir', '$dir')
	exe('file2string', {'file2string.c'})
end)

cflags{
	'-D _GNU_SOURCE',
	'-I $dir',
	'-I $outdir',
	'-I $srcdir',
	'-isystem $basedir/pkg/ffmpeg/src',
	'-isystem $builddir/pkg/ffmpeg/include',
	'-isystem $builddir/pkg/libplacebo/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/zlib/include',
}
local libs = {
	'ffmpeg/libavcodec.a.d',
	'ffmpeg/libavdevice.a.d',
	'ffmpeg/libavfilter.a.d',
	'ffmpeg/libavformat.a.d',
	'ffmpeg/libavutil.a',
	'ffmpeg/libswresample.a.d',
	'ffmpeg/libswscale.a.d',
	'libplacebo/libplacebo.a',
	'zlib/libz.a',
}
pkg.deps = {
	'$outdir/version.h',
	'pkg/ffmpeg/headers',
	'pkg/ffmpeg/fetch',
	'pkg/libplacebo/headers',
	'pkg/linux-headers/headers',
	'pkg/zlib/headers',
}

build('copy', '$outdir/content-type-v1.h', '$builddir/pkg/wayland-protocols/include/content-type-v1-client-protocol.h')
build('copy', '$outdir/fractional-scale-v1.h', '$builddir/pkg/wayland-protocols/include/fractional-scale-v1-client-protocol.h')
build('copy', '$outdir/idle-inhibit-unstable-v1.h', '$builddir/pkg/wayland-protocols/include/idle-inhibit-unstable-v1-client-protocol.h')
build('copy', '$outdir/linux-dmabuf-unstable-v1.h', '$builddir/pkg/wayland-protocols/include/linux-dmabuf-unstable-v1-client-protocol.h')
build('copy', '$outdir/presentation-time.h', '$builddir/pkg/wayland-protocols/include/presentation-time-client-protocol.h')
build('copy', '$outdir/single-pixel-buffer-v1.h', '$builddir/pkg/wayland-protocols/include/single-pixel-buffer-v1-client-protocol.h')
build('copy', '$outdir/viewporter.h', '$builddir/pkg/wayland-protocols/include/viewporter-client-protocol.h')
build('copy', '$outdir/xdg-decoration-unstable-v1.h', '$builddir/pkg/wayland-protocols/include/xdg-decoration-unstable-v1-client-protocol.h')
build('copy', '$outdir/xdg-shell.h', '$builddir/pkg/wayland-protocols/include/xdg-shell-client-protocol.h')

rule('file2string', '$outdir/file2string $in >$out')
local function file2string(src)
	local out = '$outdir/'..src..'.inc'
	build('file2string', out, {'$srcdir/'..src, '|', '$outdir/file2string'})
	table.insert(pkg.deps, out)
end

file2string('etc/input.conf')
file2string('etc/builtin.conf')
file2string('sub/osd_font.otf')
local lua = {
	'defaults.lua', 'assdraw.lua', 'options.lua', 'osc.lua',
	'ytdl_hook.lua', 'stats.lua', 'console.lua', 'auto_profiles.lua',
	'input.lua',
}
for _, f in ipairs(lua) do
	file2string('player/lua/'..f)
end

local options = {}
for line in iterlines('config.h', 1) do
	local var, val = line:match('^#define ([^ ]+) ([^ ]+)')
	if var and val == '1' then
		options[var] = true
	end
end
table.insert(pkg.inputs.gen, '$dir/config.h')

local srcs = {
	-- src/meson.build:/^sources =/
	'audio/aframe.c',
	'audio/chmap.c',
	'audio/chmap_sel.c',
	'audio/decode/ad_lavc.c',
	'audio/decode/ad_spdif.c',
	'audio/filter/af_drop.c',
	'audio/filter/af_format.c',
	'audio/filter/af_lavcac3enc.c',
	'audio/filter/af_scaletempo.c',
	'audio/filter/af_scaletempo2.c',
	'audio/filter/af_scaletempo2_internals.c',
	'audio/fmt-conversion.c',
	'audio/format.c',
	'audio/out/ao.c',
	'audio/out/ao_lavc.c',
	'audio/out/ao_null.c',
	'audio/out/ao_pcm.c',
	'audio/out/buffer.c',

	'common/av_common.c',
	'common/av_log.c',
	'common/codecs.c',
	'common/common.c',
	'common/encode_lavc.c',
	'common/msg.c',
	'common/playlist.c',
	'common/recorder.c',
	'common/stats.c',
	'common/tags.c',
	'common/version.c',

	'demux/codec_tags.c',
	'demux/cue.c',
	'demux/cache.c',
	'demux/demux.c',
	'demux/demux_cue.c',
	'demux/demux_disc.c',
	'demux/demux_edl.c',
	'demux/demux_lavf.c',
	'demux/demux_mf.c',
	'demux/demux_mkv.c',
	'demux/demux_mkv_timeline.c',
	'demux/demux_null.c',
	'demux/demux_playlist.c',
	'demux/demux_raw.c',
	'demux/demux_timeline.c',
	'demux/ebml.c',
	'demux/packet.c',
	'demux/timeline.c',

	'filters/f_async_queue.c',
	'filters/f_autoconvert.c',
	'filters/f_auto_filters.c',
	'filters/f_decoder_wrapper.c',
	'filters/f_demux_in.c',
	'filters/f_hwtransfer.c',
	'filters/f_lavfi.c',
	'filters/f_output_chain.c',
	'filters/f_swresample.c',
	'filters/f_swscale.c',
	'filters/f_utils.c',
	'filters/filter.c',
	'filters/frame.c',
	'filters/user_filters.c',

	'input/cmd.c',
	'input/event.c',
	'input/input.c',
	'input/ipc.c',
	'input/keycodes.c',

	'misc/bstr.c',
	'misc/charset_conv.c',
	'misc/dispatch.c',
	'misc/io_utils.c',
	'misc/json.c',
	'misc/language.c',
	'misc/natural_sort.c',
	'misc/node.c',
	'misc/path_utils.c',
	'misc/random.c',
	'misc/rendezvous.c',
	'misc/thread_pool.c',
	'misc/thread_tools.c',

	'options/m_config_core.c',
	'options/m_config_frontend.c',
	'options/m_option.c',
	'options/m_property.c',
	'options/options.c',
	'options/parse_commandline.c',
	'options/parse_configfile.c',
	'options/path.c',

	'player/audio.c',
	'player/client.c',
	'player/command.c',
	'player/configfiles.c',
	'player/external_files.c',
	'player/loadfile.c',
	'player/main.c',
	'player/misc.c',
	'player/osd.c',
	'player/playloop.c',
	'player/screenshot.c',
	'player/scripting.c',
	'player/sub.c',
	'player/video.c',

	'stream/cookies.c',
	'stream/stream.c',
	'stream/stream_avdevice.c',
	'stream/stream_cb.c',
	'stream/stream_concat.c',
	'stream/stream_edl.c',
	'stream/stream_file.c',
	'stream/stream_lavf.c',
	'stream/stream_memory.c',
	'stream/stream_mf.c',
	'stream/stream_null.c',
	'stream/stream_slice.c',

	'sub/ass_mp.c',
	'sub/dec_sub.c',
	'sub/draw_bmp.c',
	'sub/filter_sdh.c',
	'sub/img_convert.c',
	'sub/lavc_conv.c',
	'sub/osd.c',
	'sub/osd_libass.c',
	'sub/sd_ass.c',
	'sub/sd_lavc.c',

	'video/csputils.c',
	'video/decode/vd_lavc.c',
	'video/filter/refqueue.c',
	'video/filter/vf_format.c',
	'video/filter/vf_sub.c',
	'video/fmt-conversion.c',
	'video/hwdec.c',
	'video/image_loader.c',
	'video/image_writer.c',
	'video/img_format.c',
	'video/mp_image.c',
	'video/mp_image_pool.c',
	'video/out/aspect.c',
	'video/out/bitmap_packer.c',
	'video/out/dither.c',
	'video/out/dr_helper.c',
	'video/out/filter_kernels.c',
	--'video/out/gpu/context.c',
	--'video/out/gpu/error_diffusion.c',
	'video/out/gpu/hwdec.c',
	--'video/out/gpu/lcms.c',
	--'video/out/gpu/libmpv_gpu.c',
	--'video/out/gpu/osd.c',
	'video/out/gpu/ra.c',
	--'video/out/gpu/shader_cache.c',
	--'video/out/gpu/spirv.c',
	--'video/out/gpu/user_shaders.c',
	--'video/out/gpu/utils.c',
	--'video/out/gpu/video.c',
	--'video/out/gpu/video_shaders.c',
	'video/out/libmpv_sw.c',
	'video/out/vo.c',
	--'video/out/vo_gpu.c',
	'video/out/vo_image.c',
	'video/out/vo_lavc.c',
	'video/out/vo_libmpv.c',
	'video/out/vo_null.c',
	'video/out/vo_tct.c',
	'video/out/vo_kitty.c',
	'video/out/win_state.c',
	'video/repack.c',
	'video/sws_utils.c',

	--'video/out/placebo/ra_pl.c',
	--'video/out/placebo/utils.c',
	--'video/out/vo_gpu_next.c',
	--'video/out/gpu_next/context.c',

	'osdep/io.c',
	'osdep/semaphore-mac.c',
	'osdep/subprocess.c',
	'osdep/timer.c',

	'ta/ta.c',
	'ta/ta_talloc.c',
	'ta/ta_utils.c',

	'osdep/language-posix.c',
	'osdep/subprocess-posix.c',
	'osdep/threads-posix.c',
	'osdep/path-unix.c',
	'osdep/terminal-unix.c',
	'osdep/timer-linux.c',
	'input/ipc-unix.c',
	'osdep/poll_wrapper.c',

	'sub/filter_regex.c',
}
if options.HAVE_AV_CHANNEL_LAYOUT then
	table.insert(srcs, 'audio/chmap_avchannel.c')
end
if options.HAVE_ALSA then
	cflags{'-isystem $builddir/pkg/alsa-lib/include'}
	table.insert(srcs, 'audio/out/ao_alsa.c')
	table.insert(libs, 'alsa-lib/libasound.a')
	table.insert(pkg.deps, 'pkg/alsa-lib/headers')
end
if options.HAVE_SNDIO then
	cflags{'-isystem $builddir/pkg/sndio/include'}
	table.insert(srcs, 'audio/out/ao_sndio.c')
	table.insert(libs, 'sndio/libsndio.a')
	table.insert(pkg.deps, 'pkg/sndio/headers')
end
if options.HAVE_DRM then
	cflags{'-isystem $builddir/pkg/libdrm/include'}
	table.insert(srcs, {
		'video/drmprime.c',
		'video/out/drm_atomic.c',
		'video/out/drm_common.c',
		'video/out/drm_prime.c',
		'video/out/hwdec/hwdec_drmprime.c',
		'video/out/hwdec/hwdec_drmprime_overlay.c',
		'video/out/vo_drm.c',
	})
	table.insert(libs, 'libdrm/libdrm.a')
	table.insert(pkg.deps, 'pkg/libdrm/headers')
end
if options.HAVE_LIBASS then
	cflags{'-isystem $builddir/pkg/libass/include'}
	table.insert(libs, 'libass/libass.a.d')
	table.insert(pkg.deps, 'pkg/libass/headers')
end
if options.HAVE_LUA then
	cflags{'-isystem $builddir/pkg/lua/include'}
	table.insert(srcs, 'player/lua.c')
	table.insert(libs, 'lua/liblua.a')
	table.insert(pkg.deps, 'pkg/lua/headers')
end
if options.HAVE_WAYLAND or options.HAVE_DRM then
	table.insert(srcs, 'video/out/present_sync.c')
end
if options.HAVE_WAYLAND then
	cflags{
		'-isystem $builddir/pkg/libxkbcommon/include',
		'-isystem $builddir/pkg/wayland/include',
	}
	table.insert(srcs, {
		'video/out/vo_wlshm.c',
		'video/out/wayland_common.c',
		'$builddir/pkg/wayland-protocols/content-type-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/fractional-scale-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/idle-inhibit-unstable-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/linux-dmabuf-unstable-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/single-pixel-buffer-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/presentation-time-protocol.c.o',
		'$builddir/pkg/wayland-protocols/viewporter-protocol.c.o',
		'$builddir/pkg/wayland-protocols/xdg-decoration-unstable-v1-protocol.c.o',
		'$builddir/pkg/wayland-protocols/xdg-shell-protocol.c.o',
	})
	table.insert(libs, {
		'wayland/libwayland-client.a.d',
		'wayland/libwayland-cursor.a.d',
		'libxkbcommon/libxkbcommon.a',
	})
	table.insert(pkg.deps, {
		'$outdir/content-type-v1.h',
		'$outdir/fractional-scale-v1.h',
		'$outdir/idle-inhibit-unstable-v1.h',
		'$outdir/linux-dmabuf-unstable-v1.h',
		'$outdir/single-pixel-buffer-v1.h',
		'$outdir/presentation-time.h',
		'$outdir/viewporter.h',
		'$outdir/xdg-decoration-unstable-v1.h',
		'$outdir/xdg-shell.h',
		'pkg/libxkbcommon/headers',
		'pkg/wayland/headers',
	})
end

exe('mpv', {'osdep/main-fn-unix.c', srcs, expand{'$builddir/pkg/', libs}})
file('bin/mpv', '755', '$outdir/mpv')
man{'$dir/mpv.1'}

fetch 'git'
