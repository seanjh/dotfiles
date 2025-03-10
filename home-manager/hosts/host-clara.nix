{ config, pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  home.username = "sean";
  home.homeDirectory = "/Users/sean";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
      ];
    })
  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile "${baseDir}/tmux.conf"}

      set-option -g default-shell ${pkgs.bash}/bin/bash
    '';
  };

}
