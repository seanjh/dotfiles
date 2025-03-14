{ pkgs, ... }:
{
  home.username = "sean";
  home.homeDirectory = "/Users/sean";

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
      ];
    })
    unstable.ollama
  ];

  fonts.fontconfig.enable = true;

  programs.bash = {
    bashrcExtra = '''';
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
          "-c"
          "tmux attach || tmux"
        ];
      };
    };
  };

  launchd.agents.ollama = with pkgs; {
    enable = true;
    config = {
      Label = "com.ollama.service";
      ProgramArguments = [
        "${pkgs.unstable.ollama}/bin/ollama"
        "serve"
      ];
      KeepAlive = true;
      RunAtLoad = true;
      EnvironmentVariables.PATH = "";
      StandardOutPath = "${config.home.homeDirectory}/.local/state/ollama.log";
      StandardErrorPath = "${config.home.homeDirectory}/.local/state/ollama.log";
    };
  };
}
