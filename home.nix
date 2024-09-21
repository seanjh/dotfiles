{ config, pkgs, ... }:

{
  imports = [ ./hosts ]

  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    gcc
    git
    gnumake
    go
    jq
    nodejs_22
    python312
    pyenv
    ripgrep
    unzip
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    stdlib = ''
    '';
  };

  programs.readline = with pkgs; {
    enable = true;
    extraConfig = lib.strings.fileContents ./inputrc;
  };

  programs.neovim = with pkgs; {
    enable = true;
    extraLuaConfig = lib.strings.fileContents ./init.lua;
  };

  programs.tmux = with pkgs; {
    enable = true;
    extraConfig = lib.strings.fileContents ./tmux.conf;
  };
}
