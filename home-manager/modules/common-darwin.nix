{ config, pkgs, ... }:
let
  baseDir = toString ./../..;
in
{
  home.file = {
    ".config/git/config_macos".source = "${baseDir}/gitconfig-macos";
  };
}
