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

    # neovim/lazyvim
    neovim
    ripgrep
    lua
    luarocks
    go
    nil
    cargo
    rustc
    fd
    fzf

    # runtimes
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
        export PS1="\t \[\033[32m\]\w\[\033[33m\]\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] $ "
        if [ -f ~/.config/bash/sensible.bash ]; then
          source ~/.config/bash/sensible.bash
        fi

        export dev="$HOME/dev"
        export CDPATH="$CDPATH:$HOME/dev"
      '';
    shellAliases = {
      c = "clear";
      e = "exit";
      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF -lh";
    };
    shellOptions = [
        "histappend"
        "autocd"
        "dirspell"
        "cdspell"
        "dotglob"
        "promptvars"
        "extglob"
        "globstar"
        "nocaseglob"
        "checkjobs"
    ];
    historySize = 1000000;
    historyControl = ["ignoreboth"];
    historyIgnore = ["ls" "exit" "cd"];
  };

  programs.gh.enable = true;

  home.file = {
    ".tmux.conf".source = "${baseDir}/tmux.conf";
    ".inputrc".source = "${baseDir}/inputrc";
    ".config/git/ignore".source = "${baseDir}/gitignore_global";
    ".config/git/config".source = "${baseDir}/gitconfig";
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
