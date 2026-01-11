{ pkgs, lib, ... }:
let
  beads = pkgs.buildGoModule (finalAttrs: {
    pname = "beads";
    version = "0.47.0";

    src = pkgs.fetchFromGitHub {
      owner = "steveyegge";
      repo = "beads";
      tag = "v${finalAttrs.version}";
      hash = lib.fakeSha256;
    };
    vendorHash = lib.fakeSha256;
    subPackages = [ "cmd/beads" ];
  });
in
{
  home.packages = [ beads ];
}
