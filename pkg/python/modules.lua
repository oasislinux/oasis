return {
	-- Modules/Setup.bootstrap.in
	atexit={'atexitmodule.c'},
	faulthandler={'faulthandler.c'},
	posix={'posixmodule.c'},
	_signal={'signalmodule.c'},
	_tracemalloc={'_tracemalloc.c'},
	_suggestions={'_suggestions.c'},
	_datetime={'_datetimemodule.c'},

	_codecs={'_codecsmodule.c'},
	_collections={'_collectionsmodule.c'},
	errno={'errnomodule.c'},
	_io={
		'_io/_iomodule.c',
		'_io/iobase.c',
		'_io/fileio.c',
		'_io/bytesio.c',
		'_io/bufferedio.c',
		'_io/textio.c',
		'_io/stringio.c',
	},
	itertools={'itertoolsmodule.c'},
	_sre={'_sre/sre.c'},
	_sysconfig={'_sysconfig.c'},
	_thread={'_threadmodule.c'},
	time={'timemodule.c'},
	_types={'_typesmodule.c'},
	_typing={'_typingmodule.c'},
	_weakref={'_weakref.c'},

	_abc={'_abc.c'},
	_functools={'_functoolsmodule.c'},
	_locale={'_localemodule.c'},
	_opcode={'_opcode.c'},
	_operator={'_operator.c'},
	_stat={'_stat.c'},
	--_symtable={'symtablemodule.c'},

	pwd={'pwdmodule.c'},

	-- Modules/Setup.stdlib.in
	array={'arraymodule.c'},
	_bisect={'_bisectmodule.c'},
	_csv={'_csv.c'},
	_heapq={'_heapqmodule.c'},
	_json={'_json.c'},
	--_lsprof={'_lsprof.c', 'rotatingtree.c'},
	_math_integer={'mathintegermodule.c'},
	_pickle={'_pickle.c'},
	_queue={'_queuemodule.c'},
	_random={'_randommodule.c'},
	--_remote_debugging={'_remote_debugging_module.c', '_remote_debugging/gc_stats.c', '_remote_debugging/object_reading.c', '_remote_debugging/code_objects.c', '_remote_debugging/frames.c', '_remote_debugging/frame_cache.c', '_remote_debugging/threads.c', '_remote_debugging/asyncio.c', 'remote_debugging/binary_io_writer.c', 'remote_debugging/binary_io_reader.c', 'remote_debugging/subprocess.c', 'remote_debugging/interpreters.c'},
	_struct={'_struct.c'},

	--_interpreters={'_interpretersmodule.c'},
	--_interpchannels={'_interpchannelsmodule.c'},
	--_interpqueues={'_interpqueuesmodule.c'},

	_zoneinfo={'_zoneinfo.c'},

	math={'mathmodule.c'},
	cmath={'cmathmodule.c'},
	_statistics={'_statisticsmodule.c'},

	--_decimal={'_decimal/_decimal.c'},

	binascii={'binascii.c'},
	--_bz2={'_bz2module.c'},
	--_lzma={'_lzmamodule.c'},
	--_zstd={'_zstd/module.c', '_zstd/zstddict.c', '_zstd/compressor.c', '_zstd/decompressor.c'},
	zlib={'zlibmodule.c'},

	--_dbm={'_dbmmodule.c'},
	--_gdbm={'_gdbmmodule.c'},

	--readline={'readline.c'},

	--_md5={'md5module.c'},
	--_sha1={'sha1module.c'},
	--_sha256={'sha256module.c'},
	--_sha512={'sha512module.c'},
	_sha3={'sha3module.c'},
	_blake2={'blake2module.c'},

	--_hmac={'hmacmodule.c'},

	pyexpat={'pyexpat.c', 'expat/xcs.c', 'expat/xmlparse.c', 'expat/xmlrole.c', 'expat/xmltok.c'},

	--_elementtree={'_elementtree.c'},

	--_codecs_cn={'cjkcodecs/_codecs_cn.c'},
	--_codecs_hk={'cjkcodecs/_codecs_hk.c'},
	--_codecs_iso2022={'cjkcodecs/_codecs_iso2022.c'},
	--_codecs_jp={'cjkcodecs/_codecs_jp.c'},
	--_codecs_kr={'cjkcodecs/_codecs_kr.c'},
	--_codecs_tw={'cjkcodecs/_codecs_tw.c'},
	--_multibytecodec={'cjkcodecs/multibytecodec.c'},
	unicodedata={'unicodedata.c'},

	fcntl={'fcntlmodule.c'},
	grp={'grpmodule.c'},
	mmap={'mmapmodule.c'},
	_posixsubprocess={'_posixsubprocess.c'},
	resource={'resource.c'},
	select={'selectmodule.c'},
	_socket={'socketmodule.c'},
	--syslog={'syslogmodule.c'},
	termios={'termios.c'},

	_posixshmem={'_multiprocessing/posixshmem.c'},
	_multiprocessing={'_multiprocessing/multiprocessing.c', '_multiprocessing/semaphore.c'},

	--_ctypes={'_ctypes/_ctypes.c', '_ctypes/callbacks.c', '_ctypes/callproc.c', '_ctypes/stgdict.c', '_ctypes/cfield.c'},

	--_curses={'_cursesmodule.c'},
	--_curses_panel={'_curses_panel.c'},

	--_sqlite3={'_sqlite/cache.c', '_sqlite/connection.c', '_sqlite/cursor.c', '_sqlite/microprotocols.c', '_sqlite/module.c', '_sqlite/prepare_protocol.c', '_sqlite/row.c', '_sqlite/statement.c', '_sqlite/util.c'},

	_ssl={'_ssl.c'},
	_hashlib={'_hashbearssl.c'},

	--_uuid={'_uuidmodule.c'},

	--_tkinter={'_tkinter.c', 'tkappinit.c'},

	_asyncio={'_asynciomodule.c'},
}
