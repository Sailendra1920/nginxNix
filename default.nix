let
	nixpkgs = fetchTarball  "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
        pkgs = import <nixpkgs> {};
in
{
	proxy = pkgs.callPackage ./proxy.nix { };
	keylog = pkgs.callPackage ./keylog.nix { };
	#sslderive = pkgs.callPackage ./derivessl.nix { };
	nginx = pkgs.callPackage ./deriveNginx.nix {};
}
