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
      set -g default-command "${pkgs.bash}/bin/bash -l"
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      scrolling = {
        history = 100000;
      };

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        size = 14.0;
      };

      cursor = {
        style.blinking = "On";
        unfocused_hollow = true;
      };

      terminal.shell = {
        program = "${pkgs.bash}/bin/bash";
        args = [ "--login" ];
      };
    };
  };

}
