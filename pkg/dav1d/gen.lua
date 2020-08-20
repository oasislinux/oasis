cflags{
	'-Wall', '-Wno-maybe-uninitialized',
	'-I $srcdir',
	'-I $srcdir/include',
	'-I $srcdir/tools',
	'-I $outdir',
	'-I $outdir/include/dav1d',
	'-I $dir',
}
nasmflags{
	'-i $srcdir/src/',
	'-i $outdir/',
	'-f elf64',
}

pkg.hdrs = {
	copy('$outdir/include/dav1d', '$srcdir/include/dav1d', {
		'common.h',
		'data.h',
		'dav1d.h',
		'headers.h',
		'picture.h',
	}),
	'$outdir/include/dav1d/version.h',
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/cli_config.h',
	'$outdir/vcs_version.h',
	'$outdir/config.asm',
}

build('sed', '$outdir/include/dav1d/version.h', '$srcdir/include/dav1d/version.h.in', {
	expr={
		'-e s,@DAV1D_API_VERSION_MAJOR@,4,',
		'-e s,@DAV1D_API_VERSION_MINOR@,0,',
		'-e s,@DAV1D_API_VERSION_PATCH@,2,',
	},
})
build('awk', '$outdir/vcs_version.h', '$dir/ver', {
	expr=[['{printf "#define DAV1D_VERSION \"%s\"\n", $$1}']],
})
build('awk', '$outdir/config.asm', '$dir/config.h', {
	expr=[['$$1 == "#define" {print "%define " substr($$0, length("#define ") + 1)}']],
})
build('touch', '$outdir/cli_config.h')

local srcs = paths[[
	src/(
		cdf.c
		cpu.c
		data.c
		decode.c
		dequant_tables.c
		getbits.c
		intra_edge.c
		itx_1d.c
		lf_mask.c
		log.c
		msac.c
		obu.c
		picture.c
		qm.c
		ref.c
		refmvs.c
		scan.c
		tables.c
		warpmv.c
		wedge.c

		lib.c
		thread_task.c

		@x86_64 x86/(
			cpu.c msac_init.c
			cpuid.asm msac.asm

			cdef_avx512.asm
			cdef_avx2.asm
			film_grain.asm
			ipred.asm
			itx.asm
			loopfilter.asm
			looprestoration.asm
			mc.asm
			cdef_sse.asm
			film_grain_ssse3.asm
			ipred_ssse3.asm
			itx_ssse3.asm
			loopfilter_ssse3.asm
			looprestoration_ssse3.asm
			mc_sse.asm
		)
	)
]]

local tmpl = paths[[
	cdef_apply_tmpl.c
	cdef_tmpl.c
	fg_apply_tmpl.c
	film_grain_tmpl.c
	ipred_prepare_tmpl.c
	ipred_tmpl.c
	itx_tmpl.c
	lf_apply_tmpl.c
	loopfilter_tmpl.c
	looprestoration_tmpl.c
	lr_apply_tmpl.c
	mc_tmpl.c
	recon_tmpl.c

	@x86_64 x86/(
		cdef_init_tmpl.c
		film_grain_init_tmpl.c
		ipred_init_tmpl.c
		itx_init_tmpl.c
		loopfilter_init_tmpl.c
		looprestoration_init_tmpl.c
		mc_init_tmpl.c
	)
]]
for _, bit in ipairs{'8', '16'} do
	for _, src in ipairs(tmpl) do
		local obj = ('$outdir/%s/%s.o'):format(bit, src)
		build('cc', obj, {'$srcdir/src/'..src, '||', '$dir/deps'}, {cflags='$cflags -D BITDEPTH='..bit})
		table.insert(srcs, obj)
	end
end

lib('libdav1d.a', srcs)

exe('dav1d', [[
	tools/(
		dav1d.c
		dav1d_cli_parse.c
		input/(input.c annexb.c ivf.c section5.c)
		output/(md5.c null.c output.c y4m2.c yuv.c)
	)
	libdav1d.a
]])
file('bin/dav1d', '755', '$outdir/dav1d')

fetch 'git'
