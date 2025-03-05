{
  config,
  pkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  baseDir = toString ./../..;
  unstablePkgs = import nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  home.stateVersion = "24.05";

  home.packages =
    with pkgs;
    [
      fontconfig
      git
      curl
      tmux
      direnv
      jq
      unzip

      # building
      gcc
      gnumake

      # neovim/lazyvim
      neovim
      ripgrep
      lua
      luarocks
      fd
      fzf

      # js/ts
      prettierd

      # nix
      nil
      nixfmt-rfc-style

      # rust
      cargo
      rustc

      # other useful runtimes to have around
      python312
      python312Packages.pip
      nodejs_22
      go_1_23
    ]
    ++ (with unstablePkgs; [
      # AI
      aider-chat
    ]);

  imports = [
    ./programs/claude-code.nix
    ./programs/aider-chat.nix
    ./programs/bash.nix
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.gh.enable = true;

  home.file = {
    "./.tmux.conf".source = "${baseDir}/tmux.conf";
    "./.inputrc".source = "${baseDir}/inputrc";
    "./.config/git/ignore".source = "${baseDir}/gitignore_global";
    "./.config/git/config".source = "${baseDir}/gitconfig";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
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
    };
  };
}
