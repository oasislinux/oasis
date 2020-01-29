local function havedriver(name)
	local enabled = config.video_drivers and config.video_drivers[name]
	return '-D HAVE_'..name:upper()..'='..(enabled and '1' or '0')
end

cflags{
	'-include $dir/config.h',
	havedriver('intel'),
	havedriver('nouveau'),
	havedriver('amdgpu'),
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/include/drm',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'xf86drm.h', 'xf86drmMode.h'}),
	copy('$outdir/include', '$srcdir/amdgpu', {'amdgpu.h'}),
	copy('$outdir/include', '$srcdir/include/drm', {
		'drm.h',
		'drm_fourcc.h',
		'drm_mode.h',
		'drm_sarea.h',
		'i915_drm.h',
		'amdgpu_drm.h',
	}),
}

lib('libdrm.a', {
	'xf86drm.c',
	'xf86drmHash.c',
	'xf86drmRandom.c',
	'xf86drmSL.c',
	'xf86drmMode.c',
})

if config.video_drivers and config.video_drivers['intel'] then
	cflags{'-I $basedir/pkg/libpciaccess/src/include'}
	pkg.deps = {'pkg/libpciaccess/fetch'}
	lib('libdrm_intel.a', [[
		intel/(
			intel_bufmgr.c
			intel_bufmgr_fake.c
			intel_bufmgr_gem.c
			intel_decode.c
			mm.c
			intel_chipset.c
		)
		$builddir/pkg/libpciaccess/libpciaccess.a
	]])
end

if config.video_drivers and config.video_drivers['nouveau'] then
	lib('libdrm_nouveau.a', [[
		nouveau/(
			nouveau.c
			pushbuf.c
			bufctx.c
			abi16.c
		)
	]])
end

if config.video_drivers and config.video_drivers['amdgpu'] then
	cflags{[[-D 'AMDGPU_ASIC_ID_TABLE="/share/libdrm/amdgpu.ids"']]}
	lib('libdrm_amdgpu.a', [[
		amdgpu/(
			amdgpu_asic_id.c
			amdgpu_bo.c
			amdgpu_cs.c
			amdgpu_device.c
			amdgpu_gpu_info.c
			amdgpu_vamgr.c
			amdgpu_vm.c
			handle_table.c
		)
	]])
	file('share/libdrm/amdgpu.ids', '644', '$srcdir/data/amdgpu.ids')
end

fetch 'git'
