{
  config,
  pkgs,
  lib,
  ...
}:
let
  baseDir = toString ./../..;
in
{
  home.stateVersion = "24.05";

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
    lua
    luarocks
    fd
    fzf
    lazygit

    # js/ts
    unstable.prettierd

    # nix
    nil
    nixfmt-rfc-style

    # other useful languages/runtimes to have around
    (unstable.python312.withPackages (
      ps: with ps; [
        pip
        uv
      ]
    ))
    unstable.nodejs_20
    go_1_23
    cargo
    rustc

    bleeding-edge._1password-cli
  ];

  imports = [
    ./programs/bash.nix
    ./programs/tmux.nix
    ./programs/readline.nix
    ./programs/claude-code.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.gh.enable = true;

  home.file = {
    "./.config/git/ignore".source = "${baseDir}/gitignore_global";
    "./.config/git/config".source = "${baseDir}/gitconfig";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    stdlib = '''';
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
