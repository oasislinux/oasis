# libxkbcommon

## config.h
Generated with

	meson \
		--prefix=/ \
		-Dxkb-config-root=/share/xkb \
		-Dx-locale-root=/share/xlocale \
		-Denable-x11=false \
		-Denable-wayland=false \
		-Denable-docs=false \
		build
