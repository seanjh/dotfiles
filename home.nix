let 
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  home.username = "sean";
  home.homeDirectory = "/home/sean";
  
  home.packages = with pkgs; [
    direnv
    git
    go
    jq
    neovim
    nodejs_20
    python312
    pyenv
    ripgrep
  ];


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.direnv = {
  	enable = true;
	stdlib = ''
	'';
  };

  programs.readline = {
  	enable = true;
	extraConfig = ''
	# Use the text that has already been typed as the prefix for searching through
	# commands (i.e. more intelligent Up/Down behavior)
	"\e[A": history-search-backward
	"\e[B": history-search-forward

	# Completion tweaks
	set completion-ignore-case on
	set completion-map-case on
	set show-all-if-ambiguous on
	set mark-symlinked-directories on
	set match-hidden-files on
	# set visible-stats on
	set skip-completed-text on
	set colored-stats on

	# Allow UTF-8 input and output
	set input-meta on
	set output-meta on
	set convert-meta off

	# Bash-specific mappings and settings
	$if Bash
	  Space: magic-space
	  \C-w: backward-kill-word
	  # "\C-n": menu-complete
	$endif
	'';
  };

  programs.neovim = with pkgs; {
  	enable = true;
	extraLuaConfig = lib.fileContents ~/.env/nvim/init.lua;
  };

  programs.tmux = {
	enable = true;
	extraConfig = ''
	# Remap prefix from `C-b` to `C+a`
	unbind C-b
	set-option -g prefix C-a
	bind-key C-a send-prefix

	# Easier split commands
	bind | split-window -
	bind - split-window -v

	# Config reloads
	bind r source-file ~/.tmux.conf

	# Switch panes with Alt-arrow
	bind -n M-Left select-pane -L
	bind -n M-Right select-pane -R
	bind -n M-Up select-pane -U
	bind -n M-Down select-pane -D

	# Enable mouse control
	set -g mouse on

	# Reduce ESC delay for Vim
	set-option -s escape-time 10

	# https://github.com/tmux/tmux/wiki/FAQ#how-do-i-use-a-256-colour-terminal
	set -g default-terminal "screen-256color"

	set-option -g history-limit 5000
	'';
  };
}
