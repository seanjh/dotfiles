{ pkgs ? import <nixpkgs> {} }:

let

  message = "hello world";

in

pkgs.mkShellNoCC {

  buildInputs = with pkgs; [ cowsay ];


}

let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
	packages = with pkgs; [
		cowsay
		lolcat
	];

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];

	shellHook = ''
	'';
}
