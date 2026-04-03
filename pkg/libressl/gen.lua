cflags{
	'-std=c11', '-Wall', '-Wundef', '-Wno-attributes',
	'-D _DEFAULT_SOURCE',
	'-D LIBRESSL_INTERNAL',
	'-D OPENSSL_NO_HW_PADLOCK',
	'-D OPENSSL_NO_ASM',
	'-D __BEGIN_HIDDEN_DECLS=',
	'-D __END_HIDDEN_DECLS=',
	[[-D '__warn_references(sym,msg)=_Static_assert(1, "")']],
	'-I $srcdir/crypto/hidden',
	'-I $srcdir/ssl/hidden',
	'-I $srcdir/include',
	'-I $srcdir/crypto',
	'-I $srcdir/crypto/arch/amd64',
	'-I $srcdir/crypto/aes',
	'-I $srcdir/crypto/asn1',
	'-I $srcdir/crypto/bio',
	'-I $srcdir/crypto/bn',
	'-I $srcdir/crypto/bn/arch/amd64',
	'-I $srcdir/crypto/bytestring',
	'-I $srcdir/crypto/conf',
	'-I $srcdir/crypto/curve25519',
	'-I $srcdir/crypto/dh',
	'-I $srcdir/crypto/dsa',
	'-I $srcdir/crypto/ec',
	'-I $srcdir/crypto/ecdsa',
	'-I $srcdir/crypto/err',
	'-I $srcdir/crypto/evp',
	'-I $srcdir/crypto/hmac',
	'-I $srcdir/crypto/modes',
	'-I $srcdir/crypto/ocsp',
	'-I $srcdir/crypto/pkcs12',
	'-I $srcdir/crypto/rsa',
	'-I $srcdir/crypto/sha',
	'-I $srcdir/crypto/stack',
	'-I $srcdir/crypto/x509',
	'-I $basedir/pkg/openbsd/include',
	'-idirafter $srcdir/include/compat',
}

pkg.hdrs = {
	copy('$outdir/include/openssl', '$srcdir/include/openssl', {
		'aes.h',
		'asn1.h',
		'asn1t.h',
		'posix_time.h',
		'blowfish.h',
		'bio.h',
		'bn.h',
		'buffer.h',
		'camellia.h',
		'cast.h',
		'chacha.h',
		'cmac.h',
		'cms.h',
		'comp.h',
		'conf.h',
		'crypto.h',
		'ct.h',
		'curve25519.h',
		'des.h',
		'dh.h',
		'dsa.h',
		'ec.h',
		'ecdh.h',
		'ecdsa.h',
		'engine.h',
		'err.h',
		'evp.h',
		'hmac.h',
		'idea.h',
		'kdf.h',
		'lhash.h',
		'md4.h',
		'md5.h',
		'mlkem.h',
		'modes.h',
		'objects.h',
		'ocsp.h',
		'opensslconf.h',
		'opensslfeatures.h',
		'opensslv.h',
		'ossl_typ.h',
		'pem.h',
		'pkcs12.h',
		'pkcs7.h',
		'poly1305.h',
		'rand.h',
		'rc2.h',
		'rc4.h',
		'ripemd.h',
		'rsa.h',
		'sha.h',
		'sm3.h',
		'sm4.h',
		'safestack.h',
		'stack.h',
		'ts.h',
		'txt_db.h',
		'ui.h',
		'x509.h',
		'x509_vfy.h',
		'x509v3.h',

		'obj_mac.h',

		'dtls1.h',
		'srtp.h',
		'ssl.h',
		'ssl3.h',
		'tls1.h',
	}),
	install=true,
}

-- src/crypto/Makefile.am
lib('libcrypto.a', [[crypto/(
	crypto_err.c
	crypto_ex_data.c
	crypto_init.c
	crypto_legacy.c
	crypto_lock.c
	crypto_memory.c
	arch/amd64/crypto_cpu_caps.c
	aes/(
		aes.c
		aes_core.c
	)
	asn1/(
		a_bitstr.c
		a_enum.c
		a_int.c
		a_mbstr.c
		a_object.c
		a_octet.c
		a_pkey.c
		a_print.c
		a_pubkey.c
		a_strex.c
		a_string.c
		a_strnid.c
		a_time.c
		a_time_posix.c
		a_time_tm.c
		a_type.c
		a_utf8.c
		asn1_err.c
		asn1_gen.c
		asn1_item.c
		asn1_lib.c
		asn1_old.c
		asn1_old_lib.c
		asn1_par.c
		asn1_types.c
		asn_mime.c
		asn_moid.c
		bio_asn1.c
		bio_ndef.c
		p5_pbe.c
		p5_pbev2.c
		p8_pkey.c
		t_crl.c
		t_req.c
		t_spki.c
		t_x509.c
		t_x509a.c
		tasn_dec.c
		tasn_enc.c
		tasn_fre.c
		tasn_new.c
		tasn_prn.c
		tasn_typ.c
		tasn_utl.c
		x_algor.c
		x_attrib.c
		x_bignum.c
		x_crl.c
		x_exten.c
		x_long.c
		x_name.c
		x_pubkey.c
		x_req.c
		x_sig.c
		x_spki.c
		x_val.c
		x_x509.c
		x_x509a.c
	)
	bf/blowfish.c
	bio/(
		b_dump.c
		b_posix.c
		b_print.c
		b_sock.c
		bf_buff.c
		bf_nbio.c
		bf_null.c
		bio_cb.c
		bio_err.c
		bio_lib.c
		bio_meth.c
		bss_acpt.c
		bss_bio.c
		bss_conn.c
		bss_dgram.c
		bss_fd.c
		bss_file.c
		bss_mem.c
		bss_null.c
		bss_sock.c
	)
	bn/(
		bn_add.c
		bn_add_sub.c
		bn_bpsw.c
		bn_const.c
		bn_convert.c
		bn_ctx.c
		bn_div.c
		bn_err.c
		bn_exp.c
		bn_gcd.c
		bn_isqrt.c
		bn_kron.c
		bn_lib.c
		bn_mod.c
		bn_mod_sqrt.c
		bn_mod_words.c
		bn_mont.c
		bn_mul.c
		bn_prime.c
		bn_primitives.c
		bn_print.c
		bn_rand.c
		bn_recp.c
		bn_shift.c
		bn_small_primes.c
		bn_sqr.c
		bn_word.c
	)
	buffer/(buf_err.c buffer.c)
	bytestring/(bs_ber.c bs_cbb.c bs_cbs.c)
	camellia/camellia.c
	cast/cast.c
	chacha/chacha.c
	cmac/(cm_ameth.c cm_pmeth.c cmac.c)
	cms/(
		cms_asn1.c
		cms_att.c
		cms_dd.c
		cms_enc.c
		cms_env.c
		cms_err.c
		cms_ess.c
		cms_io.c
		cms_kari.c
		cms_lib.c
		cms_pwri.c
		cms_sd.c
		cms_smime.c
	)
	conf/(
		conf_api.c
		conf_def.c
		conf_err.c
		conf_lib.c
		conf_mod.c
		conf_sap.c
	)
	ct/(
		ct_b64.c
		ct_err.c
		ct_log.c
		ct_oct.c
		ct_policy.c
		ct_prn.c
		ct_sct.c
		ct_sct_ctx.c
		ct_vfy.c
		ct_x509v3.c
	)
	curve25519/(curve25519-generic.c curve25519.c)
	des/(
		des.c
		des_cksum.c
		des_enc.c
		des_fcrypt.c
		des_key.c
	)
	dh/(
		dh_ameth.c
		dh_asn1.c
		dh_check.c
		dh_err.c
		dh_gen.c
		dh_key.c
		dh_lib.c
		dh_pmeth.c
	)
	dsa/(
		dsa_ameth.c
		dsa_asn1.c
		dsa_err.c
		dsa_gen.c
		dsa_key.c
		dsa_lib.c
		dsa_meth.c
		dsa_ossl.c
		dsa_pmeth.c
		dsa_prn.c
	)
	ec/(
		ec_ameth.c
		ec_asn1.c
		ec_convert.c
		ec_curve.c
		ec_err.c
		ec_field.c
		ec_key.c
		ec_lib.c
		ec_mult.c
		ec_pmeth.c
		eck_prn.c
		ecp_hp_methods.c
		ecp_methods.c
		ecx_methods.c
	)
	ecdh/ecdh.c
	ecdsa/ecdsa.c
	engine/engine_stubs.c
	err/(err.c err_all.c err_prn.c)
	evp/(
		bio_b64.c
		bio_enc.c
		bio_md.c
		e_aes.c
		e_bf.c
		e_camellia.c
		e_cast.c
		e_chacha.c
		e_chacha20poly1305.c
		e_des.c
		e_des3.c
		e_idea.c
		e_null.c
		e_rc2.c
		e_rc4.c
		e_sm4.c
		e_xcbc_d.c
		evp_aead.c
		evp_cipher.c
		evp_digest.c
		evp_encode.c
		evp_err.c
		evp_key.c
		evp_names.c
		evp_pbe.c
		evp_pkey.c
		m_md4.c
		m_md5.c
		m_md5_sha1.c
		m_null.c
		m_ripemd.c
		m_sha1.c
		m_sha3.c
		m_sigver.c
		m_sm3.c
		p_legacy.c
		p_lib.c
		p_sign.c
		p_verify.c
		pmeth_fn.c
		pmeth_gn.c
		pmeth_lib.c
	)
	hkdf/hkdf.c
	hmac/(hm_ameth.c hm_pmeth.c hmac.c)
	idea/idea.c
	kdf/(hkdf_evp.c kdf_err.c tls1_prf.c)
	lhash/lhash.c
	md4/md4.c
	md5/md5.c
	mlkem/(mlkem.c mlkem_internal.c mlkem_key.c)
	modes/(
		cbc128.c
		ccm128.c
		cfb128.c
		ctr128.c
		gcm128.c
		ofb128.c
		xts128.c
	)
	objects/(
		obj_dat.c
		obj_err.c
		obj_lib.c
		obj_xref.c
	)
	ocsp/(
		ocsp_asn.c
		ocsp_cl.c
		ocsp_err.c
		ocsp_ext.c
		ocsp_ht.c
		ocsp_lib.c
		ocsp_prn.c
		ocsp_srv.c
		ocsp_vfy.c
	)
	pem/(
		pem_all.c
		pem_err.c
		pem_info.c
		pem_lib.c
		pem_oth.c
		pem_pk8.c
		pem_pkey.c
		pem_sign.c
		pem_x509.c
		pem_xaux.c
		pvkfmt.c
	)
	pkcs12/(
		p12_add.c
		p12_asn.c
		p12_attr.c
		p12_crt.c
		p12_decr.c
		p12_init.c
		p12_key.c
		p12_kiss.c
		p12_mutl.c
		p12_npas.c
		p12_p8d.c
		p12_p8e.c
		p12_sbag.c
		p12_utl.c
		pk12err.c
	)
	pkcs7/(
		pk7_asn1.c
		pk7_attr.c
		pk7_doit.c
		pk7_lib.c
		pk7_mime.c
		pk7_smime.c
		pkcs7err.c
	)
	poly1305/poly1305.c
	rand/(rand_err.c rand_lib.c randfile.c)
	rc2/rc2.c
	rc4/rc4.c
	ripemd/ripemd.c
	rsa/(
		rsa_ameth.c
		rsa_asn1.c
		rsa_blinding.c
		rsa_chk.c
		rsa_eay.c
		rsa_err.c
		rsa_gen.c
		rsa_lib.c
		rsa_meth.c
		rsa_none.c
		rsa_oaep.c
		rsa_pk1.c
		rsa_pmeth.c
		rsa_prn.c
		rsa_pss.c
		rsa_saos.c
		rsa_sign.c
		rsa_x931.c
	)
	sha/(sha1.c sha256.c sha3.c sha512.c)
	sm3/sm3.c
	sm4/sm4.c
	stack/stack.c
	ts/(
		ts_asn1.c
		ts_conf.c
		ts_err.c
		ts_lib.c
		ts_req_print.c
		ts_req_utils.c
		ts_rsp_print.c
		ts_rsp_sign.c
		ts_rsp_utils.c
		ts_rsp_verify.c
		ts_verify_ctx.c
	)
	txt_db/txt_db.c
	ui/(ui_err.c ui_lib.c ui_null.c ui_openssl.c)
	x509/(
		by_dir.c
		by_file.c
		by_mem.c
		x509_addr.c
		x509_akey.c
		x509_akeya.c
		x509_alt.c
		x509_asid.c
		x509_att.c
		x509_bcons.c
		x509_bitst.c
		x509_cmp.c
		x509_conf.c
		x509_constraints.c
		x509_cpols.c
		x509_crld.c
		x509_d2.c
		x509_def.c
		x509_err.c
		x509_ext.c
		x509_extku.c
		x509_genn.c
		x509_ia5.c
		x509_info.c
		x509_int.c
		x509_issuer_cache.c
		x509_lib.c
		x509_lu.c
		x509_ncons.c
		x509_obj.c
		x509_ocsp.c
		x509_pcons.c
		x509_pku.c
		x509_pmaps.c
		x509_policy.c
		x509_prn.c
		x509_purp.c
		x509_r2x.c
		x509_req.c
		x509_set.c
		x509_siginfo.c
		x509_skey.c
		x509_trs.c
		x509_txt.c
		x509_utl.c
		x509_v3.c
		x509_verify.c
		x509_vfy.c
		x509_vpm.c
		x509cset.c
		x509name.c
		x509rset.c
		x509spki.c
		x509type.c
		x_all.c
	)
) $builddir/pkg/openbsd/libbsd.a.d]])
file('lib/libcrypto.a', '644', '$outdir/libcrypto.a')

-- src/ssl/Makefile.am
lib('libssl.a', [[ssl/(
	bio_ssl.c
	bs_ber.c
	bs_cbb.c
	bs_cbs.c
	d1_both.c
	d1_lib.c
	d1_pkt.c
	d1_srtp.c
	pqueue.c
	s3_cbc.c
	s3_lib.c
	ssl_asn1.c
	ssl_both.c
	ssl_cert.c
	ssl_ciph.c
	ssl_ciphers.c
	ssl_clnt.c
	ssl_err.c
	ssl_init.c
	ssl_kex.c
	ssl_lib.c
	ssl_methods.c
	ssl_packet.c
	ssl_pkt.c
	ssl_rsa.c
	ssl_seclevel.c
	ssl_sess.c
	ssl_sigalgs.c
	ssl_srvr.c
	ssl_stat.c
	ssl_tlsext.c
	ssl_transcript.c
	ssl_txt.c
	ssl_versions.c
	t1_enc.c
	t1_lib.c
	tls12_key_schedule.c
	tls12_lib.c
	tls12_record_layer.c
	tls13_client.c
	tls13_error.c
	tls13_handshake.c
	tls13_handshake_msg.c
	tls13_key_schedule.c
	tls13_legacy.c
	tls13_lib.c
	tls13_quic.c
	tls13_record.c
	tls13_record_layer.c
	tls13_server.c
	tls_buffer.c
	tls_content.c
	tls_key_share.c
	tls_lib.c
) libcrypto.a.d]])
file('lib/libssl.a', '644', '$outdir/libssl.a')

exe('openssl', [[apps/openssl/(
	apps.c apps_posix.c asn1pars.c ca.c certhash.c ciphers.c cms.c crl.c
	crl2p7.c dgst.c dh.c dhparam.c dsa.c dsaparam.c ec.c ecparam.c enc.c
	errstr.c gendh.c gendsa.c genpkey.c genrsa.c ocsp.c
	openssl.c passwd.c pkcs12.c pkcs7.c pkcs8.c pkey.c pkeyparam.c
	pkeyutl.c prime.c rand.c req.c rsa.c rsautl.c s_cb.c s_client.c
	s_server.c s_socket.c s_time.c sess_id.c smime.c speed.c ts.c
	verify.c version.c x509.c
) libssl.a.d libcrypto.a.d]])
file('bin/openssl', '755', '$outdir/openssl')
man{'apps/openssl/openssl.1'}

fetch 'curl'
