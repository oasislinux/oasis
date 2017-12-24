cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/include/drm',
}

lib('libdrm.a', {
	'xf86drm.c',
	'xf86drmHash.c',
	'xf86drmRandom.c',
	'xf86drmSL.c',
	'xf86drmMode.c',
})

if config.video_drivers and config.video_drivers['intel'] then
	cflags{'-D HAVE_INTEL=1', '-I pkg/libpciaccess/src/include'}
	pkg.deps = {'pkg/libpciaccess/fetch'}
	lib('libdrm_intel.a', [[
		intel/(
			intel_bufmgr.c
			intel_bufmgr_fake.c
			intel_bufmgr_gem.c
			intel_decode.c
			mm.c
		)
		$builddir/pkg/libpciaccess/libpciaccess.a
	]])
end

if config.video_drivers and config.video_drivers['nouveau'] then
	cflags{'-D HAVE_NOUVEAU=1'}
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
	cflags{
		'-D HAVE_AMDGPU=1',
		[[-D 'AMDGPU_ASIC_ID_TABLE="/share/libdrm/amdgpu.ids"']],
	}
	lib('libdrm_amdgpu.a', [[
		amdgpu/(
			amdgpu_asic_id.c
			amdgpu_bo.c
			amdgpu_cs.c
			amdgpu_device.c
			amdgpu_gpu_info.c
			amdgpu_vamgr.c
			amdgpu_vm.c
			util_hash.c
			util_hash_table.c
		)
	]])
	file('share/libdrm/amdgpu.ids', '644', '$srcdir/data/amdgpu.ids')
end

fetch 'git'
