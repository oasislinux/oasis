cflags{
	'-std=c11', '-Wall',
	'-I include',
	'-I $dir',
	'-I $srcdir/include',
	'-I pkg/libevdev/src',
	'-I pkg/mtdev/src/include',
}

pkg.deps = {
	'pkg/libevdev/fetch',
	'pkg/mtdev/fetch',
}

lib('libinput.a', [[
	src/(
		libinput.c
		libinput-util.c
		evdev.c
		evdev-debounce.c
		evdev-fallback.c
		evdev-middle-button.c
		evdev-mt-touchpad.c
		evdev-mt-touchpad-tap.c
		evdev-mt-touchpad-buttons.c
		evdev-mt-touchpad-edge-scroll.c
		evdev-mt-touchpad-gestures.c
		evdev-tablet.c
		evdev-tablet-pad.c
		evdev-tablet-pad-leds.c
		filter.c
		netlink-seat.c
		path-seat.c
		timer.c
	)
	$builddir/pkg/(
		libevdev/libevdev.a
		mtdev/libmtdev.a
	)
]])

fetch 'git'
