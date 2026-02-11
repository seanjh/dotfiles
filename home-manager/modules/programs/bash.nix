{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bashInteractive
  ];

  home.file = {
    "./.config/bash/sensible".source = "${fetchGit {
      url = "https://github.com/mrzool/bash-sensible";
      rev = "89fa380e3d46210a85b4236098ada2c2ae280ac4";
    }}";
  };

  programs.bash = with pkgs; {
    enable = true;
    enableCompletion = true;
    initExtra = lib.mkBefore ''
      if [ -f ~/.config/bash/sensible/sensible.bash ]; then
        source ~/.config/bash/sensible/sensible.bash
      fi

      if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        export PS1='\t \[\033[35m\]\u@\h:\[\033[00m\] \[\033[32m\]\w\[\033[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] \$ '
      else
        export PS1='\t \[\033[32m\]\w\[\033[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] \$ '
      fi
      source ${git}/share/git/contrib/completion/git-prompt.sh
    '';
    bashrcExtra = lib.mkBefore ''
      [ -f ~/.config/secrets ] && source ~/.config/secrets

      # disable terminal bell urgency (dock bouncing on macOS)
      # https://github.com/alacritty/alacritty/issues/2950
      # https://github.com/alacritty/alacritty/pull/4304
      printf "\e[?1042l"
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
}
