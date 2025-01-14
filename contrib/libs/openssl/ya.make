LIBRARY()

LICENSE(
    OpenSSL
    SSLeay
)



NO_COMPILER_WARNINGS()

NO_UTIL()

PEERDIR(
    contrib/libs/openssl/crypto
    contrib/libs/zlib
)

ADDINCL(
    contrib/libs/openssl
    contrib/libs/openssl/crypto
    contrib/libs/openssl/crypto/ec/curve448
    contrib/libs/openssl/crypto/ec/curve448/arch_32
    contrib/libs/openssl/crypto/include
    contrib/libs/openssl/crypto/modes
    contrib/libs/openssl/include
    contrib/libs/zlib
    GLOBAL contrib/libs/openssl/include
)

CFLAGS(
    -DECP_NISTZ256_ASM
    -DKECCAK1600_ASM
    -DOPENSSL_BN_ASM_MONT
    -DOPENSSL_CPUID_OBJ
    -DPOLY1305_ASM
    -DSHA1_ASM
    -DSHA256_ASM
    -DSHA512_ASM
    -DVPAES_ASM
)

IF (NOT OS_WINDOWS)
    CFLAGS(
        -DENGINESDIR=\"/usr/local/lib/engines-1.1\"
        -DOPENSSLDIR=\"/usr/local/ssl\"
    )
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64 OR OS_LINUX AND ARCH_X86_64 OR OS_WINDOWS AND ARCH_X86_64)
    CFLAGS(
        -DAES_ASM
        -DBSAES_ASM
        -DGHASH_ASM
        -DL_ENDIAN
        -DMD5_ASM
        -DOPENSSL_BN_ASM_GF2m
        -DOPENSSL_BN_ASM_MONT5
        -DOPENSSL_IA32_SSE2
        -DPADLOCK_ASM
        -DRC4_ASM
        -DX25519_ASM
    )
ENDIF()

IF (OS_LINUX AND ARCH_AARCH64 OR OS_LINUX AND ARCH_X86_64)
    CFLAGS(-DOPENSSL_USE_NODELETE)
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64)
    CFLAGS(
        -D_REENTRANT
    )
ENDIF()

IF (OS_WINDOWS AND ARCH_X86_64)
    CFLAGS(
        -DENGINESDIR="\"C:\\\\Program\ Files\\\\OpenSSL\\\\lib\\\\engines-1_1\""
        -DOPENSSLDIR="\"C:\\\\Program\ Files\\\\Common\ Files\\\\SSL\""
        -DOPENSSL_SYS_WIN32
        -DUNICODE
        -DWIN32_LEAN_AND_MEAN
        -D_CRT_SECURE_NO_DEPRECATE
        -D_UNICODE
        -D_WINSOCK_DEPRECATED_NO_WARNINGS
        /GF
    )
ENDIF()

IF (SANITIZER_TYPE STREQUAL memory)
    CFLAGS(-DPURIFY)
ENDIF()

IF (MUSL)
    CFLAGS(-DOPENSSL_NO_ASYNC)
ENDIF()

IF (ARCH_TYPE_32)
    CFLAGS(-DOPENSSL_NO_EC_NISTP_64_GCC_128)
ENDIF()

SRCS(
    # XXX the rest is in contrib/libs/openssl/crypto
    crypto/evp/bio_b64.c
    crypto/evp/bio_enc.c
    crypto/evp/bio_md.c
    crypto/evp/bio_ok.c
    crypto/evp/c_allc.c
    crypto/evp/c_alld.c
    crypto/evp/cmeth_lib.c
    crypto/evp/digest.c
    crypto/evp/e_aes.c
    crypto/evp/e_aes_cbc_hmac_sha1.c
    crypto/evp/e_aes_cbc_hmac_sha256.c
    crypto/evp/e_aria.c
    crypto/evp/e_bf.c
    crypto/evp/e_camellia.c
    crypto/evp/e_cast.c
    crypto/evp/e_chacha20_poly1305.c
    crypto/evp/e_des.c
    crypto/evp/e_des3.c
    crypto/evp/e_idea.c
    crypto/evp/e_null.c
    crypto/evp/e_old.c
    crypto/evp/e_rc2.c
    crypto/evp/e_rc4.c
    crypto/evp/e_rc4_hmac_md5.c
    crypto/evp/e_rc5.c
    crypto/evp/e_seed.c
    crypto/evp/e_sm4.c
    crypto/evp/e_xcbc_d.c
    crypto/evp/encode.c
    crypto/evp/evp_cnf.c
    crypto/evp/evp_enc.c
    crypto/evp/evp_err.c
    crypto/evp/evp_key.c
    crypto/evp/evp_lib.c
    crypto/evp/evp_pbe.c
    crypto/evp/evp_pkey.c
    crypto/evp/m_md2.c
    crypto/evp/m_md4.c
    crypto/evp/m_md5.c
    crypto/evp/m_md5_sha1.c
    crypto/evp/m_mdc2.c
    crypto/evp/m_null.c
    crypto/evp/m_ripemd.c
    crypto/evp/m_sha1.c
    crypto/evp/m_sha3.c
    crypto/evp/m_sigver.c
    crypto/evp/m_wp.c
    crypto/evp/names.c
    crypto/evp/p5_crpt.c
    crypto/evp/p5_crpt2.c
    crypto/evp/p_dec.c
    crypto/evp/p_enc.c
    crypto/evp/p_lib.c
    crypto/evp/p_open.c
    crypto/evp/p_seal.c
    crypto/evp/p_sign.c
    crypto/evp/p_verify.c
    crypto/evp/pbe_scrypt.c
    crypto/evp/pmeth_fn.c
    crypto/evp/pmeth_gn.c
    crypto/evp/pmeth_lib.c
    crypto/ex_data.c
    crypto/getenv.c
    crypto/hmac/hm_ameth.c
    crypto/hmac/hm_pmeth.c
    crypto/hmac/hmac.c
    crypto/idea/i_cbc.c
    crypto/idea/i_cfb64.c
    crypto/idea/i_ecb.c
    crypto/idea/i_ofb64.c
    crypto/idea/i_skey.c
    crypto/init.c
    crypto/kdf/hkdf.c
    crypto/kdf/kdf_err.c
    crypto/kdf/scrypt.c
    crypto/kdf/tls1_prf.c
    crypto/lhash/lh_stats.c
    crypto/lhash/lhash.c
    crypto/md4/md4_dgst.c
    crypto/md4/md4_one.c
    crypto/md5/md5_dgst.c
    crypto/md5/md5_one.c
    crypto/mdc2/mdc2_one.c
    crypto/mdc2/mdc2dgst.c
    crypto/mem.c
    crypto/mem_dbg.c
    crypto/mem_sec.c
    crypto/modes/cbc128.c
    crypto/modes/ccm128.c
    crypto/modes/cfb128.c
    crypto/modes/ctr128.c
    crypto/modes/cts128.c
    crypto/modes/gcm128.c
    crypto/modes/ocb128.c
    crypto/modes/ofb128.c
    crypto/modes/wrap128.c
    crypto/modes/xts128.c
    crypto/o_dir.c
    crypto/o_fips.c
    crypto/o_fopen.c
    crypto/o_init.c
    crypto/o_str.c
    crypto/o_time.c
    crypto/objects/o_names.c
    crypto/objects/obj_dat.c
    crypto/objects/obj_err.c
    crypto/objects/obj_lib.c
    crypto/objects/obj_xref.c
    crypto/ocsp/ocsp_asn.c
    crypto/ocsp/ocsp_cl.c
    crypto/ocsp/ocsp_err.c
    crypto/ocsp/ocsp_ext.c
    crypto/ocsp/ocsp_ht.c
    crypto/ocsp/ocsp_lib.c
    crypto/ocsp/ocsp_prn.c
    crypto/ocsp/ocsp_srv.c
    crypto/ocsp/ocsp_vfy.c
    crypto/ocsp/v3_ocsp.c
    crypto/pem/pem_all.c
    crypto/pem/pem_err.c
    crypto/pem/pem_info.c
    crypto/pem/pem_lib.c
    crypto/pem/pem_oth.c
    crypto/pem/pem_pk8.c
    crypto/pem/pem_pkey.c
    crypto/pem/pem_sign.c
    crypto/pem/pem_x509.c
    crypto/pem/pem_xaux.c
    crypto/pem/pvkfmt.c
    crypto/pkcs12/p12_add.c
    crypto/pkcs12/p12_asn.c
    crypto/pkcs12/p12_attr.c
    crypto/pkcs12/p12_crpt.c
    crypto/pkcs12/p12_crt.c
    crypto/pkcs12/p12_decr.c
    crypto/pkcs12/p12_init.c
    crypto/pkcs12/p12_key.c
    crypto/pkcs12/p12_kiss.c
    crypto/pkcs12/p12_mutl.c
    crypto/pkcs12/p12_npas.c
    crypto/pkcs12/p12_p8d.c
    crypto/pkcs12/p12_p8e.c
    crypto/pkcs12/p12_sbag.c
    crypto/pkcs12/p12_utl.c
    crypto/pkcs12/pk12err.c
    crypto/pkcs7/bio_pk7.c
    crypto/pkcs7/pk7_asn1.c
    crypto/pkcs7/pk7_attr.c
    crypto/pkcs7/pk7_doit.c
    crypto/pkcs7/pk7_lib.c
    crypto/pkcs7/pk7_mime.c
    crypto/pkcs7/pk7_smime.c
    crypto/pkcs7/pkcs7err.c
    crypto/poly1305/poly1305.c
    crypto/poly1305/poly1305_ameth.c
    crypto/poly1305/poly1305_pmeth.c
    crypto/rand/drbg_ctr.c
    crypto/rand/drbg_lib.c
    crypto/rand/rand_egd.c
    crypto/rand/rand_err.c
    crypto/rand/rand_lib.c
    crypto/rand/rand_unix.c
    crypto/rand/rand_win.c
    crypto/rand/randfile.c
    crypto/rc2/rc2_cbc.c
    crypto/rc2/rc2_ecb.c
    crypto/rc2/rc2_skey.c
    crypto/rc2/rc2cfb64.c
    crypto/rc2/rc2ofb64.c
    crypto/ripemd/rmd_dgst.c
    crypto/ripemd/rmd_one.c
    crypto/rsa/rsa_ameth.c
    crypto/rsa/rsa_asn1.c
    crypto/rsa/rsa_chk.c
    crypto/rsa/rsa_crpt.c
    crypto/rsa/rsa_depr.c
    crypto/rsa/rsa_err.c
    crypto/rsa/rsa_gen.c
    crypto/rsa/rsa_lib.c
    crypto/rsa/rsa_meth.c
    crypto/rsa/rsa_mp.c
    crypto/rsa/rsa_none.c
    crypto/rsa/rsa_oaep.c
    crypto/rsa/rsa_ossl.c
    crypto/rsa/rsa_pk1.c
    crypto/rsa/rsa_pmeth.c
    crypto/rsa/rsa_prn.c
    crypto/rsa/rsa_pss.c
    crypto/rsa/rsa_saos.c
    crypto/rsa/rsa_sign.c
    crypto/rsa/rsa_ssl.c
    crypto/rsa/rsa_x931.c
    crypto/rsa/rsa_x931g.c
    crypto/seed/seed.c
    crypto/seed/seed_cbc.c
    crypto/seed/seed_cfb.c
    crypto/seed/seed_ecb.c
    crypto/seed/seed_ofb.c
    crypto/sha/sha1_one.c
    crypto/sha/sha1dgst.c
    crypto/sha/sha256.c
    crypto/sha/sha512.c
    crypto/siphash/siphash.c
    crypto/siphash/siphash_ameth.c
    crypto/siphash/siphash_pmeth.c
    crypto/sm2/sm2_crypt.c
    crypto/sm2/sm2_err.c
    crypto/sm2/sm2_pmeth.c
    crypto/sm2/sm2_sign.c
    crypto/sm3/m_sm3.c
    crypto/sm3/sm3.c
    crypto/sm4/sm4.c
    crypto/srp/srp_lib.c
    crypto/srp/srp_vfy.c
    crypto/stack/stack.c
    crypto/store/loader_file.c
    crypto/store/store_err.c
    crypto/store/store_init.c
    crypto/store/store_lib.c
    crypto/store/store_register.c
    crypto/store/store_strings.c
    crypto/threads_none.c
    crypto/threads_pthread.c
    crypto/threads_win.c
    crypto/ts/ts_asn1.c
    crypto/ts/ts_conf.c
    crypto/ts/ts_err.c
    crypto/ts/ts_lib.c
    crypto/ts/ts_req_print.c
    crypto/ts/ts_req_utils.c
    crypto/ts/ts_rsp_print.c
    crypto/ts/ts_rsp_sign.c
    crypto/ts/ts_rsp_utils.c
    crypto/ts/ts_rsp_verify.c
    crypto/ts/ts_verify_ctx.c
    crypto/txt_db/txt_db.c
    crypto/ui/ui_err.c
    crypto/ui/ui_lib.c
    crypto/ui/ui_null.c
    crypto/ui/ui_openssl.c
    crypto/ui/ui_util.c
    crypto/uid.c
    crypto/whrlpool/wp_dgst.c
    crypto/x509/by_dir.c
    crypto/x509/by_file.c
    crypto/x509/t_crl.c
    crypto/x509/t_req.c
    crypto/x509/t_x509.c
    crypto/x509/x509_att.c
    crypto/x509/x509_cmp.c
    crypto/x509/x509_d2.c
    crypto/x509/x509_def.c
    crypto/x509/x509_err.c
    crypto/x509/x509_ext.c
    crypto/x509/x509_lu.c
    crypto/x509/x509_meth.c
    crypto/x509/x509_obj.c
    crypto/x509/x509_r2x.c
    crypto/x509/x509_req.c
    crypto/x509/x509_set.c
    crypto/x509/x509_trs.c
    crypto/x509/x509_txt.c
    crypto/x509/x509_v3.c
    crypto/x509/x509_vfy.c
    crypto/x509/x509_vpm.c
    crypto/x509/x509cset.c
    crypto/x509/x509name.c
    crypto/x509/x509rset.c
    crypto/x509/x509spki.c
    crypto/x509/x509type.c
    crypto/x509/x_all.c
    crypto/x509/x_attrib.c
    crypto/x509/x_crl.c
    crypto/x509/x_exten.c
    crypto/x509/x_name.c
    crypto/x509/x_pubkey.c
    crypto/x509/x_req.c
    crypto/x509/x_x509.c
    crypto/x509/x_x509a.c
    crypto/x509v3/pcy_cache.c
    crypto/x509v3/pcy_data.c
    crypto/x509v3/pcy_lib.c
    crypto/x509v3/pcy_map.c
    crypto/x509v3/pcy_node.c
    crypto/x509v3/pcy_tree.c
    crypto/x509v3/v3_addr.c
    crypto/x509v3/v3_admis.c
    crypto/x509v3/v3_akey.c
    crypto/x509v3/v3_akeya.c
    crypto/x509v3/v3_alt.c
    crypto/x509v3/v3_asid.c
    crypto/x509v3/v3_bcons.c
    crypto/x509v3/v3_bitst.c
    crypto/x509v3/v3_conf.c
    crypto/x509v3/v3_cpols.c
    crypto/x509v3/v3_crld.c
    crypto/x509v3/v3_enum.c
    crypto/x509v3/v3_extku.c
    crypto/x509v3/v3_genn.c
    crypto/x509v3/v3_ia5.c
    crypto/x509v3/v3_info.c
    crypto/x509v3/v3_int.c
    crypto/x509v3/v3_lib.c
    crypto/x509v3/v3_ncons.c
    crypto/x509v3/v3_pci.c
    crypto/x509v3/v3_pcia.c
    crypto/x509v3/v3_pcons.c
    crypto/x509v3/v3_pku.c
    crypto/x509v3/v3_pmaps.c
    crypto/x509v3/v3_prn.c
    crypto/x509v3/v3_purp.c
    crypto/x509v3/v3_skey.c
    crypto/x509v3/v3_sxnet.c
    crypto/x509v3/v3_tlsf.c
    crypto/x509v3/v3_utl.c
    crypto/x509v3/v3err.c
    engines/e_capi.c
    engines/e_padlock.c
    ssl/bio_ssl.c
    ssl/d1_lib.c
    ssl/d1_msg.c
    ssl/d1_srtp.c
    ssl/methods.c
    ssl/packet.c
    ssl/pqueue.c
    ssl/record/dtls1_bitmap.c
    ssl/record/rec_layer_d1.c
    ssl/record/rec_layer_s3.c
    ssl/record/ssl3_buffer.c
    ssl/record/ssl3_record.c
    ssl/record/ssl3_record_tls13.c
    ssl/s3_cbc.c
    ssl/s3_enc.c
    ssl/s3_lib.c
    ssl/s3_msg.c
    ssl/ssl_asn1.c
    ssl/ssl_cert.c
    ssl/ssl_ciph.c
    ssl/ssl_conf.c
    ssl/ssl_err.c
    ssl/ssl_init.c
    ssl/ssl_lib.c
    ssl/ssl_mcnf.c
    ssl/ssl_rsa.c
    ssl/ssl_sess.c
    ssl/ssl_stat.c
    ssl/ssl_txt.c
    ssl/ssl_utst.c
    ssl/statem/extensions.c
    ssl/statem/extensions_clnt.c
    ssl/statem/extensions_cust.c
    ssl/statem/extensions_srvr.c
    ssl/statem/statem.c
    ssl/statem/statem_clnt.c
    ssl/statem/statem_dtls.c
    ssl/statem/statem_lib.c
    ssl/statem/statem_srvr.c
    ssl/t1_enc.c
    ssl/t1_lib.c
    ssl/t1_trce.c
    ssl/tls13_enc.c
    ssl/tls_srp.c
)

IF (OS_DARWIN AND ARCH_X86_64 OR OS_LINUX AND ARCH_X86_64 OR OS_WINDOWS AND ARCH_X86_64)
    SRCS(
        crypto/bn/rsaz_exp.c
    )
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64 OR OS_LINUX AND ARCH_X86_64)
    SRCS(
        crypto/bn/asm/x86_64-gcc.c
    )
ENDIF()

IF (OS_LINUX AND ARCH_AARCH64 OR OS_LINUX AND ARCH_X86_64 OR OS_LINUX AND ARCH_PPC64LE)
    SRCS(
        engines/e_afalg.c
    )
ENDIF()

IF (OS_LINUX AND ARCH_AARCH64 OR OS_WINDOWS AND ARCH_X86_64 OR OS_LINUX AND ARCH_PPC64LE)
    SRCS(
        crypto/bn/bn_asm.c
    )
ENDIF()

IF (OS_DARWIN AND ARCH_X86_64)
    SRCS(
        asm/darwin/crypto/aes/aes-x86_64.s
        asm/darwin/crypto/aes/aesni-mb-x86_64.s
        asm/darwin/crypto/aes/aesni-sha1-x86_64.s
        asm/darwin/crypto/aes/aesni-sha256-x86_64.s
        asm/darwin/crypto/aes/aesni-x86_64.s
        asm/darwin/crypto/aes/bsaes-x86_64.s
        asm/darwin/crypto/aes/vpaes-x86_64.s
        asm/darwin/crypto/bn/rsaz-avx2.s
        asm/darwin/crypto/bn/rsaz-x86_64.s
        asm/darwin/crypto/bn/x86_64-gf2m.s
        asm/darwin/crypto/bn/x86_64-mont.s
        asm/darwin/crypto/bn/x86_64-mont5.s
        asm/darwin/crypto/camellia/cmll-x86_64.s
        asm/darwin/crypto/chacha/chacha-x86_64.s
        asm/darwin/crypto/ec/ecp_nistz256-x86_64.s
        asm/darwin/crypto/ec/x25519-x86_64.s
        asm/darwin/crypto/md5/md5-x86_64.s
        asm/darwin/crypto/modes/aesni-gcm-x86_64.s
        asm/darwin/crypto/modes/ghash-x86_64.s
        asm/darwin/crypto/poly1305/poly1305-x86_64.s
        asm/darwin/crypto/rc4/rc4-md5-x86_64.s
        asm/darwin/crypto/rc4/rc4-x86_64.s
        asm/darwin/crypto/sha/keccak1600-x86_64.s
        asm/darwin/crypto/sha/sha1-mb-x86_64.s
        asm/darwin/crypto/sha/sha1-x86_64.s
        asm/darwin/crypto/sha/sha256-mb-x86_64.s
        asm/darwin/crypto/sha/sha256-x86_64.s
        asm/darwin/crypto/sha/sha512-x86_64.s
        asm/darwin/crypto/whrlpool/wp-x86_64.s
        asm/darwin/crypto/x86_64cpuid.s
        asm/darwin/engines/e_padlock-x86_64.s
    )
ENDIF()

IF (OS_LINUX AND ARCH_AARCH64)
    SRCS(
        asm/aarch64/crypto/aes/aesv8-armx.S
        asm/aarch64/crypto/aes/vpaes-armv8.S
        asm/aarch64/crypto/arm64cpuid.S
        asm/aarch64/crypto/bn/armv8-mont.S
        asm/aarch64/crypto/chacha/chacha-armv8.S
        asm/aarch64/crypto/ec/ecp_nistz256-armv8.S
        asm/aarch64/crypto/modes/ghashv8-armx.S
        asm/aarch64/crypto/poly1305/poly1305-armv8.S
        asm/aarch64/crypto/sha/keccak1600-armv8.S
        asm/aarch64/crypto/sha/sha1-armv8.S
        asm/aarch64/crypto/sha/sha256-armv8.S
        asm/aarch64/crypto/sha/sha512-armv8.S
        crypto/aes/aes_cbc.c
        crypto/aes/aes_core.c
        crypto/armcap.c
        crypto/camellia/camellia.c
        crypto/camellia/cmll_cbc.c
        crypto/rc4/rc4_enc.c
        crypto/rc4/rc4_skey.c
        crypto/whrlpool/wp_block.c
    )
ENDIF()

IF (OS_LINUX AND ARCH_PPC64LE)
    SRCS(
        asm/ppc64le/crypto/aes/aesp8-ppc.s
        asm/ppc64le/crypto/aes/vpaes-ppc.s
        asm/ppc64le/crypto/bn/bn-ppc.s
        asm/ppc64le/crypto/bn/ppc-mont.s
        asm/ppc64le/crypto/bn/ppc64-mont.s
        asm/ppc64le/crypto/chacha/chacha-ppc.s
        asm/ppc64le/crypto/ec/ecp_nistz256-ppc64.s
        asm/ppc64le/crypto/ec/x25519-ppc64.s
        asm/ppc64le/crypto/modes/ghashp8-ppc.s
        asm/ppc64le/crypto/poly1305/poly1305-ppc.s
        asm/ppc64le/crypto/poly1305/poly1305-ppcfp.s
        asm/ppc64le/crypto/ppccpuid.s
        asm/ppc64le/crypto/sha/keccak1600-ppc64.s
        asm/ppc64le/crypto/sha/sha1-ppc.s
        asm/ppc64le/crypto/sha/sha256-ppc.s
        asm/ppc64le/crypto/sha/sha256p8-ppc.s
        asm/ppc64le/crypto/sha/sha512-ppc.s
        asm/ppc64le/crypto/sha/sha512p8-ppc.s
        crypto/aes/aes_cbc.c
        crypto/aes/aes_core.c
        crypto/ppccap.c
        crypto/camellia/camellia.c
        crypto/camellia/cmll_cbc.c
        crypto/rc4/rc4_enc.c
        crypto/rc4/rc4_skey.c
        crypto/whrlpool/wp_block.c
    )
ENDIF()

IF (OS_LINUX AND ARCH_X86_64)
    SRCS(
        asm/linux/crypto/aes/aes-x86_64.s
        asm/linux/crypto/aes/aesni-mb-x86_64.s
        asm/linux/crypto/aes/aesni-sha1-x86_64.s
        asm/linux/crypto/aes/aesni-sha256-x86_64.s
        asm/linux/crypto/aes/aesni-x86_64.s
        asm/linux/crypto/aes/bsaes-x86_64.s
        asm/linux/crypto/aes/vpaes-x86_64.s
        asm/linux/crypto/bn/rsaz-avx2.s
        asm/linux/crypto/bn/rsaz-x86_64.s
        asm/linux/crypto/bn/x86_64-gf2m.s
        asm/linux/crypto/bn/x86_64-mont.s
        asm/linux/crypto/bn/x86_64-mont5.s
        asm/linux/crypto/camellia/cmll-x86_64.s
        asm/linux/crypto/chacha/chacha-x86_64.s
        asm/linux/crypto/ec/ecp_nistz256-x86_64.s
        asm/linux/crypto/ec/x25519-x86_64.s
        asm/linux/crypto/md5/md5-x86_64.s
        asm/linux/crypto/modes/aesni-gcm-x86_64.s
        asm/linux/crypto/modes/ghash-x86_64.s
        asm/linux/crypto/poly1305/poly1305-x86_64.s
        asm/linux/crypto/rc4/rc4-md5-x86_64.s
        asm/linux/crypto/rc4/rc4-x86_64.s
        asm/linux/crypto/sha/keccak1600-x86_64.s
        asm/linux/crypto/sha/sha1-mb-x86_64.s
        asm/linux/crypto/sha/sha1-x86_64.s
        asm/linux/crypto/sha/sha256-mb-x86_64.s
        asm/linux/crypto/sha/sha256-x86_64.s
        asm/linux/crypto/sha/sha512-x86_64.s
        asm/linux/crypto/whrlpool/wp-x86_64.s
        asm/linux/crypto/x86_64cpuid.s
        asm/linux/engines/e_padlock-x86_64.s
    )
ENDIF()

IF (OS_WINDOWS AND ARCH_X86_64)
    SRCS(
        asm/windows/crypto/aes/aes-x86_64.asm
        asm/windows/crypto/aes/aesni-mb-x86_64.asm
        asm/windows/crypto/aes/aesni-sha1-x86_64.asm
        asm/windows/crypto/aes/aesni-sha256-x86_64.asm
        asm/windows/crypto/aes/aesni-x86_64.asm
        asm/windows/crypto/aes/bsaes-x86_64.asm
        asm/windows/crypto/aes/vpaes-x86_64.asm
        asm/windows/crypto/bn/rsaz-avx2.asm
        asm/windows/crypto/bn/rsaz-x86_64.asm
        asm/windows/crypto/bn/x86_64-gf2m.asm
        asm/windows/crypto/bn/x86_64-mont.asm
        asm/windows/crypto/bn/x86_64-mont5.asm
        asm/windows/crypto/camellia/cmll-x86_64.asm
        asm/windows/crypto/chacha/chacha-x86_64.asm
        asm/windows/crypto/ec/ecp_nistz256-x86_64.asm
        asm/windows/crypto/ec/x25519-x86_64.asm
        asm/windows/crypto/md5/md5-x86_64.asm
        asm/windows/crypto/modes/aesni-gcm-x86_64.asm
        asm/windows/crypto/modes/ghash-x86_64.asm
        asm/windows/crypto/poly1305/poly1305-x86_64.asm
        asm/windows/crypto/rc4/rc4-md5-x86_64.asm
        asm/windows/crypto/rc4/rc4-x86_64.asm
        asm/windows/crypto/sha/keccak1600-x86_64.asm
        asm/windows/crypto/sha/sha1-mb-x86_64.asm
        asm/windows/crypto/sha/sha1-x86_64.asm
        asm/windows/crypto/sha/sha256-mb-x86_64.asm
        asm/windows/crypto/sha/sha256-x86_64.asm
        asm/windows/crypto/sha/sha512-x86_64.asm
        asm/windows/crypto/whrlpool/wp-x86_64.asm
        asm/windows/crypto/x86_64cpuid.asm
        asm/windows/engines/e_padlock-x86_64.asm
    )
ENDIF()

END()
