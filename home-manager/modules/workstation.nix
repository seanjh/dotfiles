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

    unstable.devbox
    bleeding-edge._1password-cli

    unstable.devbox
  ];

  imports = [
    ./programs/bash.nix
    ./programs/tmux.nix
    ./programs/readline.nix
    ./programs/claude-code.nix
    ./programs/typos.nix
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
    stdlib = ''
            layout_uv() {
          if [[ -d ".venv" ]]; then
              VIRTUAL_ENV="$(pwd)/.venv"
          fi

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
              log_status "No virtual environment exists. Executing \`uv venv\` to create one."
              uv venv
              VIRTUAL_ENV="$(pwd)/.venv"
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export UV_ACTIVE=1  # or VENV_ACTIVE=1
          export VIRTUAL_ENV
      }
    '';
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
