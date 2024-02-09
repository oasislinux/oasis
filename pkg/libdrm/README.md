# libdrm

# `config.h`
Generated with

	meson build -Dintel=disabled -Dnouveau=disabled -Dradeon=disabled -Dvmwgfx=disabled

`HAVE_INTEL` and `HAVE_NOUVEAU` were removed since they get defined
in `gen.lua` based on the keys in `config.video_drivers`.
