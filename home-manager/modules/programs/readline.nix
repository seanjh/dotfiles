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
      # visible-stats = true
      skip-completed-text = true;
      colored-stats = true;

      # Allow UTF-8 input and output
      input-meta = true;
      output-meta = true;
      convert-meta = false;
    };

    extraConfig = ''
      # Bash-specific mappings and settings
      $if Bash
        Space: magic-space
        \C-w: backward-kill-word
        # "\C-n": menu-complete
      $endif
    '';
  };
}
