{ pkgs, ... }:
{
  home.file = {
    "./.config/bash/sensible.bash".source = "${fetchGit {
      url = "https://github.com/mrzool/bash-sensible";
      rev = "89fa380e3d46210a85b4236098ada2c2ae280ac4";
    }}";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        # SSH connection - include user@host
        export PS1='\t \[\033[35m\]\u@\h:\[\033[00m\] \[\033[32m\]\w\[\033[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] \$ '
      else
        # Local terminal - minimal prompt
        export PS1='\t \[\033[32m\]\w\[\033[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\] \$ '
      fi
      if [ -f ~/.config/bash/sensible.bash ]; then
        source ~/.config/bash/sensible.bash
      fi

      [ -f ~/.config/secrets ] && source ~/.config/secrets
      source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
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
