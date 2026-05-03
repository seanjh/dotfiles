{ pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";

    packages = with pkgs; [
      git
      curl
      btop
      mtr
      ripgrep
      jq
      unzip
      vim
      tmux
      fzf
      fd
    ];

    sessionVariables = {
      EDITOR = "vim";
    };

    file = {
      "./.config/git/ignore".source = "${baseDir}/gitignore_global";
      "./.config/git/config".source = "${baseDir}/gitconfig";
      "./.vimrc".source = "${baseDir}/vimrc";
    };
  };

  imports = [
    ./programs/bash.nix
    ./programs/readline.nix
    ./programs/tmux.nix
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
