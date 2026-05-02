{ config, pkgs, ... }:
{
  home.username = "sean";
  home.homeDirectory = "/home/sean";

  home.packages = with pkgs; [
    neovim
    ripgrep
    lua5_1
    lua51Packages.luarocks
    fd
    fzf
    lazygit
  ];
}
