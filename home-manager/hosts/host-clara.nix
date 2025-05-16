{ pkgs, lib, ... }:
{
  home.username = "sean";
  home.homeDirectory = "/Users/sean";

  imports = [
    (import ../modules/programs/alacritty.nix {
      inherit pkgs;
      shell = pkgs.bashInteractive;
    })
  ];

  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
      ];
    })
    unstable.ollama
    unstable.postgresql_16
    unstable.ngrok
    bleeding-edge.raycast
    bleeding-edge.graphite-cli
    bleeding-edge.podman
    # npm-openai-codex
  ];

  fonts.fontconfig.enable = true;

  # increase max files per process over the prohibitive default of 256
  home.file."Library/LaunchAgents/limit.maxfiles.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>limit.maxfiles</string>

        <key>ProgramArguments</key>
        <array>
          <string>launchctl</string>
          <string>limit</string>
          <string>maxfiles</string>
          <string>8192</string>
          <string>8192</string>
        </array>

        <key>RunAtLoad</key>
        <true/>
      </dict>
      </plist>
    '';
    executable = false;
  };

  programs.bash = {
    bashrcExtra = with pkgs; lib.mkAfter '''';
  };

  launchd.agents = {
    ollama = {
      enable = true;
      config = {
        Label = "com.ollama.service";
        ProgramArguments = [
          "${pkgs.unstable.ollama}/bin/ollama"
          "serve"
        ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
        EnvironmentVariables.PATH = "";
        StandardOutPath = "/Users/sean/.local/state/ollama.log";
        StandardErrorPath = "/Users/sean/.local/state/ollama.log";
      };
    };

    postgres = {
      enable = true;
      config = {
        Label = "org.postgresql.postgres";
        ProgramArguments = [
          "${pkgs.unstable.postgresql_16}/bin/postgres"
          "-D"
          "/Users/sean/.local/share/postgresql/data"
        ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
        EnvironmentVariables = {
          LC_ALL = "C.UTF-8";
        };
        StandardOutPath = "/Users/sean/.local/state/postgresql/postgres.log";
        StandardErrorPath = "/Users/sean/.local/state/postgresql/error.log";
      };
    };
  };
}