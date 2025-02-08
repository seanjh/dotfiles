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

    # building
    gcc
    gnumake
    autoconf
    automake
    pkg-config
    openssl
    libiconv
    libyaml
    libffi

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

    # AI
    aider-chat
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH =
      with pkgs;
      lib.makeSearchPath "lib/pkgconfig" [
        "${openssl.dev}"
        "${libffi.dev}"
        "${zlib.dev}/lib/pkgconfig}"
      ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PS1="\t \[\033[32m\]\w\[\033[33m\]\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] $ "
      if [ -f ~/.config/bash/sensible.bash ]; then
        source ~/.config/bash/sensible.bash
      fi

      [ -f ~/.config/secrets ] && source ~/.config/secrets
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
    sessionVariables = { };
    historySize = 1000000;
    historyControl = [ "ignoreboth" ];
    historyIgnore = [
      "ls"
      "exit"
      "cd"
    ];
  };

  programs.gh.enable = true;

  home.file = {
    "./.tmux.conf".source = "${baseDir}/tmux.conf";
    "./.inputrc".source = "${baseDir}/inputrc";
    "./.config/git/ignore".source = "${baseDir}/gitignore_global";
    "./.config/git/config".source = "${baseDir}/gitconfig";
    "./.config/bash/sensible.bash".source = "${fetchGit {
      url = "https://github.com/mrzool/bash-sensible";
      rev = "89fa380e3d46210a85b4236098ada2c2ae280ac4";
    }}";
    aidir-chat = {
      target = ".aider.conf.yml";
      text = ''
        watch-files: true
        analytics-disable: true
        check-update: false
        vim: true
        multiline: true
      '';
    };
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
