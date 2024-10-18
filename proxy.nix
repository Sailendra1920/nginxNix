{
	stdenv, 
	fetchurl,
	lib 
 }:

stdenv.mkDerivation rec {
		name = "ngx_http_proxy_connect_module";
		src = fetchurl {
			url = "https://github.com/chobits/ngx_http_proxy_connect_module/archive/refs/tags/v0.0.7.tar.gz";
			sha256 = "sha256-sVAjCbCvw+JL37AqqOcCgBTQbz9OPJmkqGfegdnA5H0=";
		};
		installPhase = ''
			mkdir -p $out/module
			cp $src $out/module
		'';
}
