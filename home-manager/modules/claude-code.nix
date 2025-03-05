{
  config,
  pkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  unstablePkgs = import nixpkgs-unstable { system = pkgs.system; };
in
{
  home.packages =
    with pkgs;
    [ ]
    ++ (with unstablePkgs; [
      claude-code
    ]);

  home.activation = {
    configureClaudeCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      claude config set --global autoUpdaterStatus disabled
      claude config set --global preferredNotifChannel terminal_bell
    '';
  };
}
