{

 pkgs?import <nixpkgs> { config = { allowUnfree=true; }; }

}:

pkgs.stdenv.mkDerivation rec{
	name = "nginx_1_27";
	src = pkgs.fetchurl {
		url = "https://github.com/nginx/nginx/archive/refs/tags/release-1.27.0.tar.gz";
		sha256 = "sha256-zB7rQ4WnMTqaIuWQmi/Ruo8kZ+xggpTSlTl7ZLAxkd4=";
	};
	
	nativeBuidInputs = [ pkgs.makeWrapper pkgs.pkg-config ];
	buildInputs = with pkgs; [ cryptodev pcre2 zlib quictls libxcrypt ];

	patches = [./ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch ./nginx-sslkeylog/nginx-patches/1.25.3.patch ];
	patchPhase = ''
		patch -p1 < ${./ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch}
		patch -Np1 -i ${./nginx-sslkeylog/nginx-patches/1.25.3.patch}
	'';
	configurePhase = ''
		./auto/configure --prefix=$out/etc/nginx --sbin-path=$out/usr/sbin/nginx --conf-path=$out/etc/nginx/nginx.conf --http-log-path=$out/var/log/nginx/access.log --pid-path=$out/var/run/nginx.pid --lock-path=$out/var/run/nginx.lock --with-debug --with-http_v3_module --with-cc-opt='-DNGX_QUIC_DEBUG_PACKETS -DNGX_QUIC_DEBUG_CRYPTO' --with-http_v2_module --with-http_ssl_module --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-stream --with-stream_realip_module --with-stream_ssl_preread_module --add-module=${./ngx_http_proxy_connect_module} --add-module=${./nginx-sslkeylog}
	'';

	buildPhase = ''
		make
	'';

	installPhase = ''
		make install
		mkdir -p $out/bin
		cp $out/usr/sbin/nginx $out/bin
	'';
		
}
