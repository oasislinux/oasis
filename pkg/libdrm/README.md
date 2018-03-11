# libdrm

# `config.h`
Generated with

	./configure \
		--disable-amdgpu \
		--disable-intel \
		--disable-nouveau \
		--disable-radeon \
		--disable-vmwgfx

`HAVE_INTEL`, `HAVE_NOUVEAU`, and `HAVE_AMDGPU` were removed since they get
defined in `gen.lua` based on the keys in `config.video_drivers`.
