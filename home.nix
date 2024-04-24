let 
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  home.username = "sean";
  home.homeDirectory = "/home/sean";
  
  home.packages = with pkgs; [
    gcc
    git
    gnumake
    go
    jq
    nodejs_20
    python312
    pyenv
    ripgrep
    unzip
  ];


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.direnv = {
  	enable = true;
	stdlib = ''
	'';
  };

  programs.readline = with pkgs; {
  	enable = true;
	extraConfig = lib.strings.fileContents ~/.env/inputrc;
  };

  programs.neovim = with pkgs; {
  	enable = true;
	extraLuaConfig = lib.strings.fileContents ~/.env/nvim/init.lua;
  };

  programs.tmux = with pkgs; {
	enable = true;
	extraConfig = lib.strings.fileContents ~/.env/tmux.conf;
  };
}
