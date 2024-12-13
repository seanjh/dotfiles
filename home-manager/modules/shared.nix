{ config, pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    fontconfig
    git
    curl
    gnumake
    tmux
    direnv
    gcc
    jq
    unzip

    neovim
    # LazyVim dependencies
    ripgrep
    lua
    luarocks
    fzf
    fd
    lazygit

    # LSP dependencies
    go
    nil
    cargo
    rustc
    python312
    python312Packages.pip
    nodejs_22
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra =
      ''
        if [ -f ~/.config/bash/sensible.bash ]; then
            source ~/.config/bash/sensible.bash
        fi

        if [ -f ~/.config/secrets ]; then
            source ~/.config/secrets
        fi
      '';
    shellAliases = {
      c = "clear";
      e = "exit";
      ls = "ls --color=auto";
      ll = "ls -alFh";
      la = "ls -A";
      l = "ls -CF -lh";
    };
  };

  programs.gh.enable = true;

  home.file = {
    ".tmux.conf".source = "${baseDir}/tmux.conf";
    ".inputrc".source = "${baseDir}/inputrc";
    ".config/git/ignore".source = "${baseDir}/gitignore_global";
    ".config/git/config".source = "${baseDir}/gitconfig";
    ".config/git/config_linux".source = "${baseDir}/gitconfig-linux";
    ".config/bash/sensible.bash".source = "${fetchGit {
      url = "https://github.com/mrzool/bash-sensible";
      rev = "89fa380e3d46210a85b4236098ada2c2ae280ac4";
    }}";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    stdlib = ''
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
        indent_size = 4;
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
