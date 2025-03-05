{ ... }:
{
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
}
