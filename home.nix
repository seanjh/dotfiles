{ configs, pkgs, ... }:
{
  home.username = "sean";
  home.homeDirectory = "/home/sean";
  
  home.packages = [
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
}
