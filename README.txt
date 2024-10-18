Use these commands to do be able to run nginx-1.27.0

1. Build the patches
	nix-build -A keylog
	nix-build -A proxy
2. Build the nginx-1.27.0
	nix-build -A deriveNginx
3. Install the Derivation
	nix-env -f . -iA deriveNginx
4. To check if build was a success
	nix-env -q
5. Create directory
	mkdir ~/.config/nixpkgs/
6. Inside ~/.config/nixpkgs/  create overlays.nix and add the following:
	[
	( self: super: {
		nginx_1_27_0 = super.callPackage ~/Documents/nginxDev/deriveNginx.nix { };
	})
	]
7. nix-shell -p nginx_1_27_0


