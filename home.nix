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
}
