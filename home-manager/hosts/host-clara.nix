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
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = '''';

    shellAliases = {
      hm-switch = "home-manager switch --flake ${baseDir}/home-manager#clara";
      hm-switch-impure = "hm-switch --impure";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
        TERM_PROGRAM = "Alacritty";
      };

      scrolling = {
        history = 100000;
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };
        option_as_alt = "Both";
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
        program = "${pkgs.bashInteractive}/bin/bash";
        args = [
          "--login"
          # TODO(sean) re-enable
          # "-c"
          # "tmux attach || tmux"
        ];
      };
    };
  };

}
