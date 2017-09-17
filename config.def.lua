local sets = dofile 'sets.lua'

return {
	fs={
		{sets.core, exclude={'^include/', '^lib/.*%.a$'}},
	},

	-- TLS implementation (possible_values: libressl bearssl)
	tls='libressl',

	-- GPU driver (possible_values: intel nouveau)
	-- video_drivers={intel=true}
}
