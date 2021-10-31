local arch = ({
	aarch64='aarch64',
	x86_64='x86',
})[config.target.platform:match('[^-]*')]
sub('tools.ninja', function()
	toolchain(config.host)
	exe('unifdef', {'scripts/unifdef.c'})
end)


cflags{
	'-Wno-deprecated-declarations',
	'-Wno-discarded-qualifiers',
	'-D HAVE_AV_CONFIG_H',
	'-I $dir/include',
	'-I $outdir',
	'-I $outdir/include',
	'-I $outdir/internal',
	'-I $srcdir',
}

pkg.deps = {
	'$outdir/config.h',
	'$gendir/headers',
}

if arch == 'x86' then
    nasmflags{
        '-i $srcdir/',
        '-i $srcdir/libavcodec/'..arch..'/',
        '-i $srcdir/libavutil/'..arch..'/',
        '-f elf64',
        '-P $outdir/config.asm',
    }

    pkg.deps[3] = '$outdir/config.asm'
end

-- TODO: Copy the rest of the headers.
pkg.hdrs = {
	'$outdir/include/libavutil/avconfig.h',
	'$outdir/include/libavutil/ffversion.h',
}

local archprobes = {
    x86="X86_64",
    aarch64="AARCH64",
}

local probe = {
	'$builddir/probe/PIC',
    '$builddir/probe/HAVE_INLINE_ASM',
	'$builddir/probe/HAVE_MMINTRIN_H',
    '$builddir/probe/'..archprobes[arch],
}

build('cat', '$outdir/config.h', {'$dir/config-head.h', probe, '$dir/config.h', '$dir/config-tail.h'})

if arch == 'x86' then
    build('sed', '$outdir/config.asm', {probe, '$dir/config.h'}, {
        expr=[[-n -e 's,^# *,%,p']],
    })
end

build('awk', '$outdir/config.texi', '$dir/config.h', {
	expr=[['$$3 == "1" {gsub("_", "-", $$2); print "@set", tolower($$2), "yes"}']],
})
build('awk', '$outdir/include/libavutil/avconfig.h', {'$dir/config.h', '|', '$dir/avconfig.awk'}, {
	expr='-f $dir/avconfig.awk',
})

rule('genlist', 'lua $dir/list.lua $dir/config.h $type $var <$in >$out')
local function genlist(out, src, type, var)
	build('genlist', out, {src, '|', '$dir/list.lua', '$dir/config.h'}, {type=type, var=var})
	table.insert(pkg.deps, out)
end
genlist('$outdir/internal/libavfilter/filter_list.c', '$srcdir/libavfilter/allfilters.c', 'AVFilter', 'filter_list')
genlist('$outdir/internal/libavcodec/codec_list.c', '$srcdir/libavcodec/allcodecs.c', 'AVCodec', 'codec_list')
genlist('$outdir/internal/libavcodec/parser_list.c', '$srcdir/libavcodec/parsers.c', 'AVCodecParser', 'parser_list')
genlist('$outdir/internal/libavcodec/bsf_list.c', '$srcdir/libavcodec/bitstream_filters.c', 'AVBitStreamFilter', 'bitstream_filters')
genlist('$outdir/internal/libavformat/demuxer_list.c', '$srcdir/libavformat/allformats.c', 'AVInputFormat', 'demuxer_list')
genlist('$outdir/internal/libavformat/muxer_list.c', '$srcdir/libavformat/allformats.c', 'AVOutputFormat', 'muxer_list')
genlist('$outdir/internal/libavdevice/indev_list.c', '$srcdir/libavdevice/alldevices.c', 'AVInputFormat', 'indev_list')
genlist('$outdir/internal/libavdevice/outdev_list.c', '$srcdir/libavdevice/alldevices.c', 'AVOutputFormat', 'outdev_list')
genlist('$outdir/internal/libavformat/protocol_list.c', '$srcdir/libavformat/protocols.c', 'URLProtocol', 'url_protocols')

build('awk', '$outdir/include/libavutil/ffversion.h', {'$dir/ver'}, {
	expr=[['{printf "#define FFMPEG_VERSION \"%s\"\n", $$1}']],
})

local options = {}
for line in iterlines('config.h', 1) do
	local cfg, val = line:match('^#define ([^ ]+) ([^ ]+)')
    if cfg then
        options[cfg] = val == '1' or val == archprobes[arch]
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
-- combination option in libavutil/x86/Makefile
if options.HAVE_MMX_EXTERNAL then
	sources.libavutil['libavutil/x86/emms.asm'] = true
end
for lib, srcs in pairs(sources) do
	sources[lib] = table.keys(srcs)
end

if options.CONFIG_ALSA_INDEV or options.config_ALSA_OUTDEV then
	cflags{'-isystem $builddir/pkg/alsa-lib/include'}
	table.insert(pkg.deps, 'pkg/alsa-lib/headers')
	table.insert(sources.libavdevice, '$builddir/pkg/alsa-lib/libasound.a')
end

if options.CONFIG_LIBDAV1D_DECODER then
	cflags{'-isystem $builddir/pkg/dav1d/include'}
	table.insert(pkg.deps, 'pkg/dav1d/headers')
	table.insert(sources.libavcodec, '$builddir/pkg/dav1d/libdav1d.a')
end

if options.CONFIG_TLS_PROTOCOL and options.CONFIG_LIBTLS then
	cflags{'-isystem $builddir/pkg/libtls-bearssl/include'}
	table.insert(pkg.deps, 'pkg/libtls-bearssl/headers')
	table.insert(sources.libavformat, '$builddir/pkg/libtls-bearssl/libtls.a.d')
end

if options.CONFIG_TLS_PROTOCOL and options.CONFIG_OPENSSL then
	cflags{'-isystem $builddir/pkg/libressl/include'}
	table.insert(pkg.deps, 'pkg/libressl/headers')
	table.insert(sources.libavformat, '$builddir/pkg/libressl/libssl.a.d')
end

if options.CONFIG_LIBOPUS_ENCODER or options.CONFIG_LIBOPUS_DECODER then
	cflags{'-isystem $builddir/pkg/opus/include'}
	table.insert(pkg.deps, 'pkg/opus/headers')
	table.insert(sources.libavcodec, '$builddir/pkg/opus/libopus.a')
end

if options.CONFIG_ZLIB then
	cflags{'-isystem $builddir/pkg/zlib/include'}
	table.insert(pkg.deps, 'pkg/zlib/headers')
	table.insert(sources.libavformat, '$builddir/pkg/zlib/libz.a')
end

lib('libavcodec.a', {
	expand{'libavcodec/', {
		'ac3_parser.c',
		'adts_parser.c',
		'allcodecs.c',
		'avcodec.c',
		'avdct.c',
		'avpacket.c',
		'avpicture.c',
		'bitstream.c',
		'bitstream_filter.c',
		'bitstream_filters.c',
		'bsf.c',
		'codec_desc.c',
		'codec_par.c',
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
		'parser.c',
		'parsers.c',
		'profiles.c',
		'qsv_api.c',
		'raw.c',
		'utils.c',
		'vorbis_parser.c',
		'xiph.c',
        table.unpack(paths[[
            @x86_64 x86/(
                constants.c
            )

            @aarch64 aarch64/(
                neontest.c
                neon.S
            )
        ]]),
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
		'transform.c',
		'video.c',
        table.unpack(paths[[
            @aarch64 aarch64/(
                vf_nlmeans_init.c
                vf_nlmeans_neon.S
            )
        ]])
	}},
	sources.libavfilter,
	'libavutil.a',
})

cc('libavformat/protocols.c', {'$gendir/deps', '$outdir/internal/libavformat/protocol_list.c'})
lib('libavformat.a', {
	expand{'libavformat/', {
		'allformats.c',
		'avio.c',
		'aviobuf.c',
		'dump.c',
		'format.c',
		'id3v1.c',
		'id3v2.c',
		'metadata.c',
		'mux.c',
		'options.c',
		'os_support.c',
		'protocols.c.o',
		'riff.c',
		'sdp.c',
		'url.c',
		'utils.c',
	}},
	sources.libavformat,
	'libavcodec.a.d',
	'libavutil.a',
})


lib('libavutil.a', {
	expand{'libavutil/', {
		'adler32.c',
		'aes.c',
		'aes_ctr.c',
		'audio_fifo.c',
		'avstring.c',
		'avsscanf.c',
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
		'dovi_meta.c',
		'downmix_info.c',
		'encryption_info.c',
		'error.c',
		'eval.c',
		'fifo.c',
		'file.c',
		'file_open.c',
		'float_dsp.c',
		'fixed_dsp.c',
		'frame.c',
		'hash.c',
		'hdr_dynamic_metadata.c',
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
		'tx.c',
		'tx_float.c',
		'tx_double.c',
		'tx_int32.c',
		'video_enc_params.c',
		'film_grain_params.c',
        table.unpack(paths[[
            @x86_64 x86/(
                cpu.c
                fixed_dsp_init.c
                float_dsp_init.c
                imgutils_init.c
                lls_init.c
                cpuid.asm
                fixed_dsp.asm
                float_dsp.asm
                imgutils.asm
                lls.asm
            )
            @aarch64 aarch64/(
                cpu.c
                float_dsp_init.c
                float_dsp_neon.S
                asm.S
            )
        ]])
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
        table.unpack(paths[[
            @x86_64 x86/(
                audio_convert.asm
                rematrix.asm
                resample.asm
                audio_convert_init.c
                rematrix_init.c
                resample_init.c
            )

            @aarch64 aarch64/(
                audio_convert_init.c
                neontest.c
                resample_init.c
                resample.S
                audio_convert_neon.S
            )
        ]])
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
        table.unpack(paths[[
            @x86_64 x86/(
                rgb2rgb.c
                swscale.c
                yuv2rgb.c
                hscale_fast_bilinear_simd.c
                input.asm
                output.asm
                scale.asm
                rgb_2_rgb.asm
                yuv_2_rgb.asm
                yuv2yuvX.asm
            )
            @aarch64 aarch64/(
                rgb2rgb.c
                swscale.c
                swscale_unscaled.c
                hscale.S
                output.S
                rgb2rgb_neon.S
                yuv2rgb_neon.S
            )
        ]])
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

cc('fftools/cmdutils.c', {'$gendir/deps'})

exe('ffprobe', {paths[[fftools/(ffprobe.c cmdutils.c.o)]], libs})
file('bin/ffprobe', '755', '$outdir/ffprobe')

exe('ffmpeg', {paths[[fftools/(ffmpeg.c ffmpeg_opt.c ffmpeg_filter.c ffmpeg_hw.c cmdutils.c.o)]], libs})
file('bin/ffmpeg', '755', '$outdir/ffmpeg')

rule('texi2mdoc', [[$builddir/pkg/texi2mdoc/host/texi2mdoc -d 'November 7, 2018' -I $outdir $in >$out]])
build('texi2mdoc', '$outdir/ffprobe.1', {'$srcdir/doc/ffprobe.texi', '|', '$outdir/config.texi', '$builddir/pkg/texi2mdoc/host/texi2mdoc'})
build('texi2mdoc', '$outdir/ffmpeg.1', {'$srcdir/doc/ffmpeg.texi', '|', '$outdir/config.texi', '$builddir/pkg/texi2mdoc/host/texi2mdoc'})
man{'$outdir/ffprobe.1', '$outdir/ffmpeg.1'}

fetch 'git'
