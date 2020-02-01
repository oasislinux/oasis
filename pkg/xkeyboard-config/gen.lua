local data = [[
	compat/(
		accessx basic caps complete
		iso9995
		japan ledcaps ledcompose
		lednum ledscroll level5
		misc mousekeys
		olpc pc pc98 xfree86
		xtest README
	)
	geometry/(
		digital_vndr/(lk pc unix)
		sgi_vndr/(indigo indy O2)
		amiga ataritt chicony
		dell everex fujitsu
		hhk hp keytronic kinesis
		macintosh microsoft nec nokia
		northgate pc sanwa sony thinkpad
		sun teck steelseries typematrix winbook README
	)
	keycodes/(
		digital_vndr/(lk pc)
		sgi_vndr/(indigo indy iris)
		aliases
		amiga
		ataritt
		empty
		evdev
		fujitsu
		hp
		ibm
		jolla
		macintosh
		olpc
		sony
		sun
		xfree86
		xfree98
		README
	)
	rules/(
		xfree98
		xkb.dtd
		xkb.its
		README
	)
	symbols/(
		digital_vndr/(lk pc us vt)
		fujitsu_vndr/(jp us)
		hp_vndr/(us)
		jolla_vndr/(sbj)
		macintosh_vndr/(
			apple ch de dk
			fi fr
			gb is it jp
			latam nl no pt
			se us
		)
		nec_vndr/(jp)
		nokia_vndr/(rx-44 rx-51 su-8w)
		sgi_vndr/(jp)
		sharp_vndr/(sl-c3x00 ws003sh ws007sh ws011sh ws020sh)
		sony_vndr/(us)
		sun_vndr/(
			ara be br ca ch
			cz de dk ee es
			fi fr gb gr it
			jp kr lt lv nl
			no pl pt ro ru
			se sk solaris tr
			tw ua us
		)
		xfree68_vndr/(amiga ataritt)
		af al am apl
		ara at au az
		ba bd be
		bg br brai
		bt bw by
		ca cd ch
		cm cn cz
		de dk dz
		ee es et epo eu
		fi fo fr
		gb ge gh gn
		gr hr hu
		id ie il
		in iq
		ir is it
		jp
		ke kg kh
		kr kz
		la latam latin
		lk lt lv
		ma mao md me
		mk ml mm
		mn mt mv my
		ng nl no np
		parens pc ph pk pl pt
		ro rs ru
		se si sk sn
		sy th
		terminate tg
		tj tm tr trans tw tz
		ua us uz vn
		za
		altwin capslock compose ctrl empty eurosign rupeesign group inet
		keypad kpdl level3 level5 nbsp olpc shift srvr_ctrl typo
	)
	types/(
		basic cancel caps
		complete default extra
		iso9995 level5 mousekeys nokia numpad
		pc README
	)
]]
for f in iterpaths(data) do
	file('share/xkb/'..f, '644', '$srcdir/'..f)
end

local function parts(ruleset)
	return expand{'$srcdir/rules/', {
		'base.hdr.part', 'base.lists.part',
		ruleset..'.lists.base.part',
		ruleset..'.m_k.part',
		'base.l1_k.part',
		'base.l_k.part',
		'base.ml_g.part',
		'base.m_g.part',
		'base.mlv_s.part',
		'base.ml_s.part',
		'base.ml1_s.part',
		'base.ml2_s.part',
		'base.ml3_s.part',
		'base.ml4_s.part',
		ruleset..'.m_s.part',
		ruleset..'.ml_s1.part',
		'base.ml_c.part',
		'base.ml1_c.part',
		'base.m_t.part',
		'base.l1o_s.part',
		'base.l2o_s.part',
		'base.l3o_s.part',
		'base.l4o_s.part',
		'base.o_s.part',
		'base.o_c.part',
		'base.o_t.part',
	}}
end

build('cat', '$outdir/base', parts('base'))
file('share/xkb/rules/base', '644', '$outdir/base')

build('cat', '$outdir/evdev', parts('evdev'))
file('share/xkb/rules/evdev', '644', '$outdir/evdev')

fetch 'git'
