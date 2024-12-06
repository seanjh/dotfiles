{ config, pkgs, ... }:
{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    tmux
    curl
    ripgrep
    jq
    neovim
    gnumake
    bash
    direnv
  ];

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    stdlib = ''
    '';
  };

  home.sessionVariables = {
    SHELL = "${pkgs.bash}/bin/bash";
    EDITOR = "nvim";
  };
}
