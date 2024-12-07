{ config, pkgs, ... }:
{
  home.file = {
    ".config/git/config_macos".source = "${baseDir}/gitconfig-macos";
  };
}
