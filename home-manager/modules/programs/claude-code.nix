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
    config = {
      allowUnfree = true;
    };
  };
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
      export PATH="${unstablePkgs.claude-code}/bin:$PATH"
      claude config set --global autoUpdaterStatus disabled
      claude config set --global preferredNotifChannel terminal_bell
    '';
  };
}
