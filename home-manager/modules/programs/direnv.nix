{ pkgs, ... }:
let
  baseDir = toString ./../../..;
  scripts = builtins.attrNames (builtins.readDir "${baseDir}/direnv");
in
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home.file = builtins.listToAttrs (
    map (name: {
      name = ".config/direnv/lib/${name}";
      value = {
        source = "${baseDir}/direnv/${name}";
      };
    }) scripts
  );
}
