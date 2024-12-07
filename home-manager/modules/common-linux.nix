{ config, pkgs, ... }:
{
  home.file = {
    ".config/git/config_linux".source = "${baseDir}/gitconfig-linux";
  };
}
