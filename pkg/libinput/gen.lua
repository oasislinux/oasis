cflags{
	'-std=c11', '-Wall',
	'-I $dir',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/libevdev/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-isystem $builddir/pkg/mtdev/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {'libinput.h'})
pkg.deps = {
	'pkg/libevdev/headers',
	'pkg/linux-headers/headers',
	'pkg/mtdev/headers',
}

lib('libinput.a', [[
	src/(
		libinput.c
		evdev.c
		evdev-debounce.c
		evdev-fallback.c
		evdev-totem.c
		evdev-middle-button.c
		evdev-mt-touchpad.c
		evdev-mt-touchpad-tap.c
		evdev-mt-touchpad-thumb.c
		evdev-mt-touchpad-buttons.c
		evdev-mt-touchpad-edge-scroll.c
		evdev-mt-touchpad-gestures.c
		evdev-tablet.c
		evdev-tablet-pad.c
		evdev-tablet-pad-leds.c
		filter.c
		filter-flat.c
		filter-low-dpi.c
		filter-mouse.c
		filter-touchpad.c
		filter-touchpad-flat.c
		filter-touchpad-x230.c
		filter-tablet.c
		filter-trackpoint.c
		netlink-seat.c
		path-seat.c
		quirks.c
		timer.c

		util-list.c
		util-ratelimit.c
		util-strings.c
		util-prop-parsers.c
	)
	$builddir/pkg/libevdev/libevdev.a
	$builddir/pkg/mtdev/libmtdev.a
]])

local quirks = {
	-- <cd src/quirks && printf "\t'%s',\n" *.quirks
	'10-generic-keyboard.quirks',
	'10-generic-lid.quirks',
	'10-generic-trackball.quirks',
	'30-vendor-aiptek.quirks',
	'30-vendor-alps.quirks',
	'30-vendor-contour.quirks',
	'30-vendor-cypress.quirks',
	'30-vendor-elantech.quirks',
	'30-vendor-ibm.quirks',
	'30-vendor-kensington.quirks',
	'30-vendor-logitech.quirks',
	'30-vendor-madcatz.quirks',
	'30-vendor-microsoft.quirks',
	'30-vendor-razer.quirks',
	'30-vendor-synaptics.quirks',
	'30-vendor-trust.quirks',
	'30-vendor-vmware.quirks',
	'30-vendor-wacom.quirks',
	'50-system-acer.quirks',
	'50-system-apple.quirks',
	'50-system-asus.quirks',
	'50-system-chicony.quirks',
	'50-system-cyborg.quirks',
	'50-system-dell.quirks',
	'50-system-google.quirks',
	'50-system-hp.quirks',
	'50-system-lenovo.quirks',
	'50-system-sony.quirks',
	'50-system-system76.quirks',
	'50-system-toshiba.quirks',
}
for _, quirk in ipairs(quirks) do
	file('share/libinput/'..quirk, '644', '$srcdir/quirks/'..quirk)
end

fetch 'git'
