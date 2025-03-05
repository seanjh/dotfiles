{
  config,
  pkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  unstablePkgs = import nixpkgs-unstable {
    system = pkgs.system;
  };
in
{
  home.packages =
    with pkgs;
    [ ]
    ++ (with unstablePkgs; [
      aider-chat
    ]);

  home.file = {
    aider-chat = {
      target = ".aider.conf.yml";
      text = ''
        watch-files: true
        analytics-disable: true
        check-update: false
        vim: true
        multiline: true
      '';
    };
  };
}
