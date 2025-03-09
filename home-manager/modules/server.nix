{
  config,
  pkgs,
  ...
}:
let
  baseDir = toString ./../..;
in
{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    curl
    btop
    mtr
    ripgrep
    jq
    unzip
    vim
    tmux
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  imports = [
    ./programs/bash.nix
  ];

  programs.home-manager.enable = true;

  home.file = {
    "./.config/git/ignore".source = "${baseDir}/gitignore_global";
    "./.config/git/config".source = "${baseDir}/gitconfig";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
