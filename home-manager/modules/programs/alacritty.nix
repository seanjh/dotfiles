{ pkgs, ... }:
let
  alacritty-themes = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "master";
    sha256 = "sha256-n9Rvm+VqdmHyPPgkyujPm+VnWee5L4DTv6QvmEeHkUA=";
  };
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      general.import = [
        "${alacritty-themes}/themes/nord.toml"
      ];
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
          "-c"
          "tmux attach || tmux"
        ];
      };
    };
  };
}
