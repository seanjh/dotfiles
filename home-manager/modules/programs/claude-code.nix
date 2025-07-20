{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    bleeding-edge.claude-code
  ];

  home.activation = {
    configureClaudeCode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.bleeding-edge.claude-code}/bin:$PATH"
      claude config set --global autoUpdates false
      claude config set --global preferredNotifChannel terminal_bell
    '';
  };
}
