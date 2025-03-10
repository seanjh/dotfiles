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

      window = {
        padding = {
          x = 10;
          y = 10;
        };
        option_as_alt = "Both";
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
        use_thin_strokes = true;
      };

      #colors = {
      #  primary = {
      #    background = "#1E1E2E";
      #    foreground = "#CDD6F4";
      #  };
      #  cursor = {
      #    text = "#1E1E2E";
      #    cursor = "#F5E0DC";
      #  };
      #  normal = {
      #    black = "#45475A";
      #    red = "#F38BA8";
      #    green = "#A6E3A1";
      #    yellow = "#F9E2AF";
      #    blue = "#89B4FA";
      #    magenta = "#F5C2E7";
      #    cyan = "#94E2D5";
      #    white = "#BAC2DE";
      #  };
      #  bright = {
      #    black = "#585B70";
      #    red = "#F38BA8";
      #    green = "#A6E3A1";
      #    yellow = "#F9E2AF";
      #    blue = "#89B4FA";
      #    magenta = "#F5C2E7";
      #    cyan = "#94E2D5";
      #    white = "#A6ADC8";
      #  };
      #};

      cursor = {
        style.blinking = "On";
        unfocused_hollow = true;
      };

      shell = {
        program = "${pkgs.bash}/bin/bash";
        args = [ "--login" ];
      };

      key_bindings = [
        {
          key = "N";
          mods = "Command";
          action = "SpawnNewInstance";
        }
        {
          key = "Q";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "W";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "F";
          mods = "Command";
          action = "ToggleFullscreen";
        }
        {
          key = "Equals";
          mods = "Command";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Command";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Command";
          action = "ResetFontSize";
        }
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
        {
          key = "H";
          mods = "Command";
          action = "Hide";
        }
        {
          key = "K";
          mods = "Command|Shift";
          action = "ClearHistory";
        }

        # tmux bindings
        {
          key = "D";
          mods = "Command";
          chars = "\\x01\\x64";
        } # tmux prefix + d
        {
          key = "T";
          mods = "Command";
          chars = "\\x01\\x63";
        } # tmux prefix + c
        {
          key = "W";
          mods = "Command|Shift";
          chars = "\\x01\\x78";
        } # tmux prefix + x
        {
          key = "Key1";
          mods = "Command";
          chars = "\\x01\\x31";
        } # tmux prefix + 1
        {
          key = "Key2";
          mods = "Command";
          chars = "\\x01\\x32";
        } # tmux prefix + 2
      ];
    };
  };

}
