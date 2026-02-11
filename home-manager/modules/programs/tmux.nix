{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    mouse = true;
    prefix = "C-a";
    shortcut = "a";
    shell = "${pkgs.bashInteractive}/bin/bash";
    terminal = "tmux-256color";
    escapeTime = 0;
    newSession = true;
    sensibleOnTop = false;

    extraConfig = ''
      # Config reloads
      bind r source-file ~/.config/tmux/tmux.conf

      # Switch panes with Alt-arrow
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-a-256-colour-terminal
      set -sa terminal-features ",xterm-256color:RGB"

      # https://unix.stackexchange.com/a/109256
      bind  c  new-window      -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      # Resolves bizarre issues with tmux muddling/misinterpreting <Esc>j and <Esc>k as Alt-j and Alt-k
      # https://github.com/tmux/tmux/wiki/Modifier-Keys#the-escape-key
      # https://github.com/LazyVim/LazyVim/discussions/163
      # https://www.reddit.com/r/lunarvim/comments/1334htt/lunarvim_in_tmux_moving_line_up_or_down_when/
      set-option -g focus-events on
      set-window-option -g xterm-keys on

      # Window naming - detect Claude Code and rename window accordingly
      set-hook -g pane-focus-in 'run-shell "~/.config/dotfiles/scripts/tmux-window-name.sh #{pane_pid}"'

      set -g status-left-length 20
      set -g status-right-length 50
      set -g status-left '[#S] '
      set -g status-right '#{?pane_synchronized,#[bg=red]SYNC#[default] ,}%H:%M %d-%b'

      # Highlight active window
      setw -g window-status-current-style fg=colour166,bold
    '';
  };

}
