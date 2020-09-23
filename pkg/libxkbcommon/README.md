# libxkbcommon
Upstream tar archives are used over git because the parser
(src/xkbcomp/parser.y) uses various GNU extensions.

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
