cflags{
	'-D HAVE_CONFIG_H',
	'-I $outdir',
	'-I $srcdir/src/common',
	'-I $srcdir/src/liblzma/api',
	'-I $srcdir/src/liblzma/check',
	'-I $srcdir/src/liblzma/common',
	'-I $srcdir/src/liblzma/delta',
	'-I $srcdir/src/liblzma/lz',
	'-I $srcdir/src/liblzma/lzma',
	'-I $srcdir/src/liblzma/rangecoder',
	'-I $srcdir/src/liblzma/simple',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE_IMMINTRIN_H',
	'$builddir/probe/HAVE__MM_CLMULEPI64_SI128',
	'$builddir/probe/HAVE__MM_MOVEMASK_EPI8',
	'$builddir/probe/HAVE___BUILTIN_ASSUME_ALIGNED',
	'$builddir/probe/HAVE___BUILTIN_BSWAP16',
	'$builddir/probe/SIZEOF_SIZE_T',
	'$dir/config.h',
})
pkg.deps = {'$outdir/config.h'}

lib('liblzma.a', [[src/(
	common/(
		tuklib_physmem.c
		tuklib_cpucores.c
	)
	liblzma/(
		check/(
			check.c
			crc32_table.c
			crc32_fast.c
			crc64_table.c
			crc64_fast.c
			sha256.c
		)
		common/(
			common.c
			block_util.c
			easy_preset.c
			filter_common.c
			hardware_physmem.c
			index.c
			stream_flags_common.c
			string_conversion.c
			vli_size.c

			hardware_cputhreads.c
			outqueue.c

			alone_encoder.c
			block_buffer_encoder.c
			block_encoder.c
			block_header_encoder.c
			easy_buffer_encoder.c
			easy_encoder.c
			easy_encoder_memusage.c
			filter_buffer_encoder.c
			filter_encoder.c
			filter_flags_encoder.c
			index_encoder.c
			stream_buffer_encoder.c
			stream_encoder.c
			stream_flags_encoder.c
			vli_encoder.c

			stream_encoder_mt.c

			alone_decoder.c
			auto_decoder.c
			block_buffer_decoder.c
			block_decoder.c
			block_header_decoder.c
			easy_decoder_memusage.c
			file_info.c
			filter_buffer_decoder.c
			filter_decoder.c
			filter_flags_decoder.c
			index_decoder.c
			index_hash.c
			stream_buffer_decoder.c
			stream_decoder.c
			stream_flags_decoder.c
			vli_decoder.c

			stream_decoder_mt.c
		)
		delta/(
			delta_common.c
			delta_encoder.c
			delta_decoder.c
		)
		lz/(
			lz_encoder.c
			lz_encoder_mf.c
			lz_decoder.c
		)
		lzma/(
			lzma_encoder_presets.c
			lzma_encoder.c
			lzma_encoder_optimum_fast.c
			lzma_encoder_optimum_normal.c
			fastpos_table.c
			lzma_decoder.c
			lzma2_encoder.c
			lzma2_decoder.c
		)
		rangecoder/price_table.c
		simple/(
			simple_coder.c
			simple_encoder.c
			simple_decoder.c
			x86.c
			powerpc.c
			ia64.c
			arm.c
			armthumb.c
			arm64.c
			sparc.c
		)
	)
)]])

exe('xz', [[src/(
	xz/(
		args.c
		coder.c
		file_io.c
		hardware.c
		main.c
		message.c
		mytime.c
		options.c
		signals.c
		suffix.c
		util.c
		list.c
	)
	common/(
		tuklib_open_stdxxx.c
		tuklib_progname.c
		tuklib_exit.c
		tuklib_mbstr_width.c
		tuklib_mbstr_fw.c
	)
) liblzma.a]])

file('bin/xz', '755', '$outdir/xz')
man{'src/xz/xz.1'}
sym('bin/unxz', 'xz')
sym('bin/xzcat', 'xz')

fetch 'git'
