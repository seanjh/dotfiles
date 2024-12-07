{ config, pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  home.file = {
    ".config/git/config_linux".source = "${baseDir}/gitconfig-linux";
  };
}
