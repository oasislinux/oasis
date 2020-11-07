cflags{
	'-std=c11', '-Wpedantic', '-Wno-overflow', '-Wno-discarded-qualifiers',
	'-D _DEFAULT_SOURCE',
	'-include $dir/config.h',
	'-I $srcdir/include',
	'-I $srcdir/src',
}

build('sed', '$outdir/version.c', '$srcdir/src/core/version.c.in', {
	expr={
		[[-e '/$${GIT_COMMIT}/d']],
		[[-e '/$${GIT_COMMIT_SHORT}/d']],
		[[-e '/$${GIT_BRANCH}/d']],
		[[-e '/$${GIT_REV}/d']],
		[[-e 's,$${BINARY_NAME},mgba,']],
		[[-e 's,$${PROJECT_NAME},mGBA,']],
		[[-e 's,$${VERSION_STRING},0.8.4,']],
	}
})

lib('mgba_libretro.a', [[
	src/(
		platform/(
			libretro/libretro.c
			posix/memory.c
		)
		core/(
			bitmap-cache.c
			cache-set.c
			cheats.c
			config.c
			core.c
			directories.c
			input.c
			interface.c
			library.c
			lockstep.c
			log.c
			map-cache.c
			mem-search.c
			rewind.c
			scripting.c
			serialize.c
			sync.c
			thread.c
			tile-cache.c
			timing.c
		)
		util/(
			circle-buffer.c
			configuration.c
			crc32.c
			elf-read.c
			export.c
			formatting.c
			gbk-table.c
			hash.c
			patch.c
			patch-fast.c
			patch-ips.c
			patch-ups.c
			png-io.c
			ring-fifo.c
			string.c
			table.c
			text-codec.c
			vfs.c
			vfs/(vfs-mem.c vfs-fifo.c vfs-fd.c vfs-dirent.c)
		)
		gb/(
			audio.c
			cheats.c
			core.c
			gb.c
			io.c
			mbc.c
			memory.c
			overrides.c
			serialize.c
			renderers/cache-set.c
			renderers/software.c
			sio.c
			timer.c
			video.c
		)
		sm83/(
			decoder.c
			isa-sm83.c
			sm83.c
		)
		gba/(
			audio.c
			bios.c
			cheats.c
			cheats/codebreaker.c
			cheats/gameshark.c
			cheats/parv3.c
			core.c
			dma.c
			gba.c
			hardware.c
			hle-bios.c
			input.c
			io.c
			matrix.c
			memory.c
			overrides.c
			renderers/cache-set.c
			renderers/common.c
			renderers/gl.c
			renderers/software-bg.c
			renderers/software-mode0.c
			renderers/software-obj.c
			renderers/video-software.c
			savedata.c
			serialize.c
			sharkport.c
			sio.c
			timer.c
			vfame.c
			video.c
		)
		arm/(
			arm.c
			decoder-arm.c
			decoder.c
			decoder-thumb.c
			isa-arm.c
			isa-thumb.c
		)
		third-party/(
			blip_buf/blip_buf.c
			inih/ini.c
		)
	)
	$outdir/version.c
]])

fetch 'git'
