{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  programs.readline = {
    enable = true;

    bindings = {
      # Use the text that has already been typed as the prefix for searching through
      # commands (i.e. more intelligent Up/Down behavior)
      # NOTE: applies to emacs input mode due to home-manager config file layout
      "\e[A" = "history-search-backward";
      "\e[B" = "history-search-forward";
    };

    variables = {
      # Completion tweaks
      completion-ignore-case = true;
      completion-map-case = true;
      show-all-if-ambiguous = true;
      mark-symlinked-directories = true;
      match-hidden-files = true;
      skip-completed-text = true;
      colored-stats = true;
      show-mode-in-prompt = true;

      # Allow UTF-8 input and output
      input-meta = true;
      output-meta = true;
      convert-meta = false;
    };

    extraConfig = ''
      set vi-ins-mode-string "\1\e[32m\2+\1\e[0m\2 "
      set vi-cmd-mode-string "\1\e[33m\2:\1\e[0m\2 "

      set keymap vi-insert
      "\e[A": history-search-backward
      "\e[B": history-search-forward
      set keymap vi-command
      "\e[A": history-search-backward
      "\e[B": history-search-forward

      # Bash-specific mappings and settings
      $if Bash
        Space: magic-space
        \C-w: backward-kill-word
        # "\C-n": menu-complete
      $endif
    '';
  };
}
