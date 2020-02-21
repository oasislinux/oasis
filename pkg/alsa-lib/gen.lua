cflags{
	'-I $outdir',
	'-I $dir',
	'-I $dir/alsa',
	'-I $srcdir/include',
	'-I $builddir/pkg/linux-headers/include',
}

build('cat', '$outdir/config.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$dir/config.h',
})

pkg.hdrs = {
	copy('$outdir/include/alsa', '$srcdir/include/alsa', {
		'asoundef.h',
		'conf.h',
		'control.h',
		'error.h',
		'global.h',
		'input.h',
		'mixer.h',
		'mixer_abst.h',
		'output.h',
		'pcm.h',
		'pcm_external.h',
		'pcm_extplug.h',
		'pcm_ioplug.h',
		'pcm_old.h',
		'pcm_plugin.h',
		'pcm_rate.h',
		'seq.h',
		'seq_event.h',
		'seq_midi_event.h',
		'seqmid.h',
		'timer.h',
	}),
	copy('$outdir/include/alsa', '$dir/alsa', {'asoundlib.h', 'version.h'}),
}
pkg.deps = {
	'$outdir/config.h',
	'pkg/linux-headers/headers',
}

cc('src/pcm/pcm.c')
build('objcopy', '$outdir/src/pcm/pcm.nowarn.c.o', '$outdir/src/pcm/pcm.c.o', {
	objcopyflags='-R .gnu.warning.snd_pcm_hwsync',
})

lib('libasound.a', [[src/(
	conf.c confmisc.c input.c output.c async.c error.c dlmisc.c socket.c shmarea.c userfile.c names.c
	control/(
		cards.c tlv.c namehint.c hcontrol.c
		control.c control_hw.c setup.c ctlparse.c
		control_symbols.c
		control_shm.c
		control_ext.c
	)
	mixer/(bag.c mixer.c simple.c simple_none.c)
	pcm/(
		mask.c interval.c
		pcm.nowarn.c.o pcm_params.c pcm_simple.c
		pcm_hw.c pcm_misc.c pcm_mmap.c pcm_symbols.c
		pcm_generic.c pcm_plugin.c
		pcm_copy.c
		pcm_linear.c
		pcm_route.c
		pcm_mulaw.c
		pcm_alaw.c
		pcm_adpcm.c
		pcm_rate.c pcm_rate_linear.c
		pcm_plug.c
		pcm_multi.c
		pcm_shm.c
		pcm_file.c
		pcm_null.c
		pcm_empty.c
		pcm_share.c
		pcm_meter.c
		pcm_hooks.c
		pcm_lfloat.c
		pcm_dmix.c
		pcm_dshare.c
		pcm_dsnoop.c
		pcm_direct.c
		pcm_asym.c
		pcm_iec958.c
		pcm_softvol.c
		pcm_extplug.c
		pcm_ioplug.c
		pcm_mmap_emul.c
	)
	timer/(
		timer.c timer_hw.c timer_query.c timer_query_hw.c
		timer_symbols.c
	)
)]])

local conf = [[
	alsa.conf
	cards/(
		aliases.conf
		AACI.conf
		ATIIXP.conf
		ATIIXP-SPDMA.conf
		ATIIXP-MODEM.conf
		AU8810.conf
		AU8820.conf
		AU8830.conf
		Audigy.conf
		Audigy2.conf
		Aureon51.conf
		Aureon71.conf
		CA0106.conf
		CMI8338.conf
		CMI8338-SWIEC.conf
		CMI8738-MC6.conf
		CMI8738-MC8.conf
		CMI8788.conf
		CS46xx.conf
		Echo_Echo3G.conf
		EMU10K1.conf
		EMU10K1X.conf
		ENS1370.conf
		ENS1371.conf
		ES1968.conf
		FM801.conf
		FWSpeakers.conf
		FireWave.conf
		GUS.conf
		HDA-Intel.conf
		HdmiLpeAudio.conf
		ICE1712.conf
		ICE1724.conf
		ICH.conf
		ICH4.conf
		ICH-MODEM.conf
		Loopback.conf
		Maestro3.conf
		NFORCE.conf
		PC-Speaker.conf
		pistachio-card.conf
		PMac.conf
		PMacToonie.conf
		PS3.conf
		RME9636.conf
		RME9652.conf
		SI7018.conf
		SB-XFi.conf
		TRID4DWAVENX.conf
		USB-Audio.conf
		YMF744.conf
		vc4-hdmi.conf
		VIA686A.conf
		VIA8233.conf
		VIA8233A.conf
		VIA8237.conf
		VX222.conf
		VXPocket.conf
		VXPocket440.conf
	)
	pcm/(
		default.conf front.conf rear.conf center_lfe.conf side.conf
		surround21.conf surround40.conf surround41.conf
		surround50.conf surround51.conf
		surround71.conf iec958.conf hdmi.conf modem.conf
		dmix.conf dsnoop.conf
		dpl.conf
	)
]]
for f in iterpaths(conf) do
	file('share/alsa/'..f, '644', '$srcdir/src/conf/'..f)
end

fetch 'git'
