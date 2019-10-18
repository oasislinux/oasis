# libdrm

# `config.h`
Generated with

	meson build -Dintel=false -Dnouveau=false -Dradeon=false -Dvmwgfx=false -Dlibkms=false

`HAVE_INTEL`, `HAVE_NOUVEAU`, and `HAVE_AMDGPU` were removed since they get
defined in `gen.lua` based on the keys in `config.video_drivers`.
