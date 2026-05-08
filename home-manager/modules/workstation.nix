{ pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  home = {
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  home.packages = with pkgs; [
    fontconfig
    git
    curl
    tmux
    direnv
    jq
    unzip
    btop

    # building
    gcc
    gnumake

    # neovim/lazyvim dependencies
    unstable.neovim
    ripgrep
    lua5_1
    lua51Packages.luarocks
    fd
    fzf
    lazygit

    # nix
    nil
    nixfmt-rfc-style
    statix
    deadnix

    # other useful languages/runtimes to have around
    (unstable.python312.withPackages (
      ps: with ps; [
        pip
        uv
      ]
    ))

    unstable.nodejs
    go
    cargo
    rustc

    unstable.devbox
    unstable.codex
    bleeding-edge._1password-cli

    delta
    bat
    jless
  ];

  imports = [
    ./programs/bash.nix
    ./programs/tmux.nix
    ./programs/readline.nix
    ./programs/direnv.nix
    ./programs/claude-code.nix
  ];

  programs = {
    home-manager.enable = true;
    gh.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  home.file = {
    "./.config/git/ignore".source = "${baseDir}/gitignore_global";
    "./.config/git/config".source = "${baseDir}/gitconfig";
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 78;
        indent_style = "space";
        indent_size = 2;
      };
      "Makefile" = {
        indent_style = "tab";
      };
      "*.json,*.yaml" = {
        indent_style = "space";
        indent_size = 2;
      };
      "*.{py,pyi}" = {
        indent_size = 4;
        indent_style = "space";
      };
    };
  };
}
