{
	stdenv,
	fetchurl,
	lib,
}:

stdenv.mkDerivation rec{
	name = "nginx-sslkeylog";
	src = fetchurl {
                        url = "https://github.com/tiandrey/nginx-sslkeylog/archive/refs/tags/v0.2.0.tar.gz";
                        sha256 = "sha256-hZO2q33nG4+gM3n4Jv97rcDzDI7ybZu0fIMzp0g0UPk=";
        };

	installPhase = ''
			mkdir -p $out/module
			cp $src $out/module
		'';

}
