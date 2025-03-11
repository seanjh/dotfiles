{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    historyLimit = 100000;
    # focusEvents = true;
    mouse = true;
    prefix = "C-a";
    shell = "${pkgs.bashInteractive}/bin/bash";
    terminal = "tmux-256color";

    extraConfig = ''
      # Remap prefix from `C-b` to `C+a`
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # Config reloads
      bind r source-file ~/.tmux.conf

      # Switch panes with Alt-arrow
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-a-256-colour-terminal
      set -g default-terminal "tmux-256color"

      set-option -g default-command "/Users/sean/.nix-profile/bin/bash --login"

      # https://unix.stackexchange.com/a/109255
      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      set-window-option -g xterm-keys on
    '';
  };

}
