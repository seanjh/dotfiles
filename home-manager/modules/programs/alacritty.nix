{
  pkgs,
  shell ? pkgs.bashInteractive,
  ...
}:
{
  home.packages = with pkgs; [
    unstable.alacritty-theme
  ];

  programs.alacritty = with pkgs; {
    enable = true;
    package = unstable.alacritty;

    settings = {
      general.import = [
        "${alacritty-theme}/nord.toml"
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
        program = "${shell}/bin/bash";
        args = [
          "--login"
          "-c"
          "tmux attach || tmux"
        ];
      };
    };
  };
}
