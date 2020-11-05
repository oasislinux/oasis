cflags{
	'-std=c99', '-Wall', '-Wpedantic',
	'-Wno-format-truncation',
	'-D _DEFAULT_SOURCE',
	'-D __LIBRETRO__',
	'-D RIGHTSHIFT_IS_SAR',
	'-D LAGFIX',
	'-I $srcdir/libretro/libretro-common/include',
}

lib('snes9x_libretro.a', [[
	src/(
		apu.c
		bsx.c
		c4emu.c
		cheats.c
		controls.c
		cpu.c
		cpuexec.c
		dsp.c
		fxemu.c
		globals.c
		memmap.c
		obc1.c
		ppu.c
		sa1.c
		sdd1.c
		seta.c
		snapshot.c
		spc7110.c
		srtc.c
		tile.c
		hwregisters.c
	)
	filter/snes_ntsc.c
	libretro/libretro.c
	libretro/libretro-common/streams/memory_stream.c
]])

fetch 'git'
