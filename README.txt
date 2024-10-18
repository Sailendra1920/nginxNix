Git clone the ngx_http_poxy_connect_module and the nginx-sslkeylog to the directory for the patches.
Use these commands to do be able to run nginx-1.27.0

1. Build the patches
	nix-build -A keylog
	nix-build -A proxy
2. Build the nginx-1.27.0
	nix-build -A nginx
3. Install the Derivation
	nix-env -f . -iA nginx
4. To check if build was a success
	nix-env -q
5. Create directory
	mkdir ~/.config/nixpkgs/
6. Inside ~/.config/nixpkgs/  create overlays.nix and add the following:
	[
	( self: super: {
		nginx_1_27_0 = super.callPackage ~/path/to/deriveNginx.nix { };
	})
	]
7. Enter the shell
	nix-shell -p nginx_1_27_0


