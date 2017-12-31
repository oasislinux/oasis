local arch = 'x86'

cflags{
	'-Wno-deprecated-declarations',
	'-Wno-discarded-qualifiers',
	'-D HAVE_AV_CONFIG_H',
	'-I $dir',
	'-I $outdir/include',
	'-I $outdir/internal',
	'-I $srcdir',
	'-I $builddir/pkg/alsa-lib/include',
	'-I $builddir/pkg/libressl/include',
}

set('nasmflags', {
	'-i $srcdir/',
	'-i $srcdir/libavcodec/'..arch..'/',
	'-i $srcdir/libavutil/'..arch..'/',
	'-f elf64',
	'-P $outdir/config.asm',
})

build('awk', '$outdir/config.asm', '$dir/options.h', {
	expr=[['{print "%define " substr($$0, length("#define ") + 1)}']],
})
build('awk', '$outdir/config.texi', '$dir/options.h', {
	expr=[['$$3 == "1" {gsub("_", "-", $$2); print "@set", tolower($$2), "yes"}']],
})
build('awk', '$outdir/internal/libavcodec/bsf_list.c', {'$dir/options.h', '|', '$dir/bitstream_filters.awk'}, {
	expr='-f $dir/bitstream_filters.awk',
})
build('awk', '$outdir/internal/libavformat/protocol_list.c', {'$dir/options.h', '|', '$dir/protocols.awk'}, {
	expr='-f $dir/protocols.awk',
})
build('awk', '$outdir/include/libavutil/avconfig.h', {'$dir/options.h', '|', '$dir/protocols.awk'}, {
	expr='-f $dir/avconfig.awk',
})

rule('ffversion', 'sh $srcdir/ffbuild/version.sh $srcdir $out')
build('ffversion', '$outdir/include/libavutil/ffversion.h', {'|', '$srcdir/ffbuild/version.sh'})

-- TODO: Copy the rest of the headers.
pkg.hdrs = {
	'$outdir/include/libavutil/avconfig.h',
	'$outdir/include/libavutil/ffversion.h',
}
pkg.deps = {
	'$outdir/config.asm',
	'$dir/headers',
	'pkg/libressl/headers',
	'pkg/alsa-lib/headers',
}

local options = {}
for line in iterlines('options.h', 1) do
	local cfg, val = line:match('^#define ([^ ]+) ([^ ]+)')
	if cfg then
		options[cfg] = val == '1'
	end
end
local sources = {
	libavcodec={},
	libavdevice={},
	libavfilter={},
	libavformat={},
	libavutil={},
	libswresample={},
	libswscale={},
}
for line in iterlines('sources.txt', 1) do
	local i = line:find(' ', 1, true)
	local cfg = line:sub(1, i and i - 1)
	if options[cfg] then
		while i do
			local j = line:find(' ', i + 1)
			local src = line:sub(i + 1, j and j - 1)
			i = j
			j = src:find('/', 1, true)
			if not j then
				error('source path has no directory part: '..src)
			end
			local k = src:find('/', j + 1, true)
			if not k or src:sub(j + 1, k - 1) == arch then
				sources[src:sub(1, j - 1)][src] = true
			end
		end
	end
end
for lib, srcs in pairs(sources) do
	sources[lib] = table.keys(srcs)
end

cc('libavcodec/bitstream_filters.c', {'$outdir/internal/libavcodec/bsf_list.c'})
lib('libavcodec.a', {
	expand{'libavcodec/', {
		'allcodecs.c',
		'audioconvert.c',
		'avdct.c',
		'avpacket.c',
		'avpicture.c',
		'bitstream.c',
		'bitstream_filter.c',
		'bitstream_filters.c.o',
		'bsf.c',
		'codec_desc.c',
		'd3d11va.c',
		'decode.c',
		'dirac.c',
		'dv_profile.c',
		'encode.c',
		'imgconvert.c',
		'jni.c',
		'mathtables.c',
		'mediacodec.c',
		'mpeg12framerate.c',
		'options.c',
		'mjpegenc_huffman.c',
		'parser.c',
		'profiles.c',
		'qsv_api.c',
		'raw.c',
		'resample.c',
		'resample2.c',
		'utils.c',
		'vorbis_parser.c',
		'xiph.c',
		'x86/constants.c',
	}},
	sources.libavcodec,
	'libavutil.a',
})

lib('libavdevice.a', {
	expand{'libavdevice/', {
		'alldevices.c',
		'avdevice.c',
		'utils.c',
	}},
	sources.libavdevice,
	'libavcodec.a.d',
	'libavformat.a.d',
	'libavutil.a',
})

lib('libavfilter.a', {
	expand{'libavfilter/', {
		'allfilters.c',
		'audio.c',
		'avfilter.c',
		'avfiltergraph.c',
		'buffersink.c',
		'buffersrc.c',
		'drawutils.c',
		'fifo.c',
		'formats.c',
		'framepool.c',
		'framequeue.c',
		'graphdump.c',
		'graphparser.c',
		'opencl_allkernels.c',
		'transform.c',
		'video.c',
	}},
	sources.libavfilter,
	'libavutil.a',
})

cc('libavformat/protocols.c', {'$outdir/internal/libavformat/protocol_list.c'})
lib('libavformat.a', {
	expand{'libavformat/', {
		'allformats.c',
		'avio.c',
		'aviobuf.c',
		'cutils.c',
		'dump.c',
		'format.c',
		'id3v1.c',
		'id3v2.c',
		'metadata.c',
		'mux.c',
		'options.c',
		'os_support.c',
		'qtpalette.c',
		'protocols.c.o',
		'riff.c',
		'sdp.c',
		'url.c',
		'utils.c',
	}},
	sources.libavformat,
	'libavcodec.a.d',
	'libavutil.a',
	'$builddir/pkg/libressl/libssl.a.d',
})

lib('libavutil.a', {
	expand{'libavutil/', {
		'adler32.c',
		'aes.c',
		'aes_ctr.c',
		'audio_fifo.c',
		'avstring.c',
		'base64.c',
		'blowfish.c',
		'bprint.c',
		'buffer.c',
		'cast5.c',
		'camellia.c',
		'channel_layout.c',
		'color_utils.c',
		'cpu.c',
		'crc.c',
		'des.c',
		'dict.c',
		'display.c',
		'downmix_info.c',
		'error.c',
		'eval.c',
		'fifo.c',
		'file.c',
		'file_open.c',
		'float_dsp.c',
		'fixed_dsp.c',
		'frame.c',
		'hash.c',
		'hmac.c',
		'hwcontext.c',
		'imgutils.c',
		'integer.c',
		'intmath.c',
		'lfg.c',
		'lls.c',
		'log.c',
		'log2_tab.c',
		'mathematics.c',
		'mastering_display_metadata.c',
		'md5.c',
		'mem.c',
		'murmur3.c',
		'opt.c',
		'parseutils.c',
		'pixdesc.c',
		'pixelutils.c',
		'random_seed.c',
		'rational.c',
		'reverse.c',
		'rc4.c',
		'ripemd.c',
		'samplefmt.c',
		'sha.c',
		'sha512.c',
		'slicethread.c',
		'spherical.c',
		'stereo3d.c',
		'threadmessage.c',
		'time.c',
		'timecode.c',
		'tree.c',
		'twofish.c',
		'utils.c',
		'xga_font_data.c',
		'xtea.c',
		'tea.c',
		'x86/cpu.c',
		'x86/fixed_dsp_init.c',
		'x86/float_dsp_init.c',
		'x86/imgutils_init.c',
		'x86/lls_init.c',
		'x86/cpuid.asm',
		'x86/fixed_dsp.asm',
		'x86/float_dsp.asm',
		'x86/imgutils.asm',
		'x86/lls.asm',
	}},
	sources.libavutil,
})

lib('libswresample.a', {
	expand{'libswresample/', {
		'audioconvert.c',
		'dither.c',
		'options.c',
		'rematrix.c',
		'resample.c',
		'resample_dsp.c',
		'swresample.c',
		'swresample_frame.c',
		'x86/audio_convert.asm',
		'x86/rematrix.asm',
		'x86/resample.asm',
		'x86/audio_convert_init.c',
		'x86/rematrix_init.c',
		'x86/resample_init.c',
	}},
	sources.libswresample,
	'libavutil.a',
})

lib('libswscale.a', {
	expand{'libswscale/', {
		'alphablend.c',
		'hscale.c',
		'hscale_fast_bilinear.c',
		'gamma.c',
		'input.c',
		'options.c',
		'output.c',
		'rgb2rgb.c',
		'slice.c',
		'swscale.c',
		'swscale_unscaled.c',
		'utils.c',
		'yuv2rgb.c',
		'vscale.c',
		'x86/rgb2rgb.c',
		'x86/swscale.c',
		'x86/yuv2rgb.c',
		'x86/hscale_fast_bilinear_simd.c',
		'x86/input.asm',
		'x86/output.asm',
		'x86/scale.asm',
	}},
	sources.libswscale,
	'libavutil.a',
})

local libs = {
	'libavcodec.a.d',
	'libavdevice.a.d',
	'libavfilter.a.d',
	'libavformat.a.d',
	'libavutil.a',
	'libswresample.a.d',
	'libswscale.a.d',
}

cc('fftools/cmdutils.c', {'$dir/deps'})

exe('ffprobe', {paths[[fftools/(ffprobe.c cmdutils.c.o)]], libs})
file('bin/ffprobe', '755', '$outdir/ffprobe')

exe('ffmpeg', {paths[[fftools/(ffmpeg.c ffmpeg_opt.c ffmpeg_filter.c ffmpeg_hw.c cmdutils.c.o)]], libs})
file('bin/ffmpeg', '755', '$outdir/ffmpeg')

rule('texi2mdoc', 'texi2mdoc -I $outdir $in >$out.tmp && mv $out.tmp $out')
build('texi2mdoc', '$outdir/ffprobe.1', {'$srcdir/doc/ffprobe.texi', '|', '$outdir/config.texi'})
build('texi2mdoc', '$outdir/ffmpeg.1', {'$srcdir/doc/ffmpeg.texi', '|', '$outdir/config.texi'})
man{'$outdir/ffprobe.1', '$outdir/ffmpeg.1'}

fetch 'git'
