{ pkgs, ... }:
let
  buildGo124Module = pkgs.buildGoModule.override { go = pkgs.unstable.go_1_24; };

  beads = buildGo124Module rec {
    pname = "beads";
    version = "0.47.0";

    src = pkgs.fetchFromGitHub {
      owner = "steveyegge";
      repo = "beads";
      rev = "v${version}";
      hash = "sha256-p7l4wla+8vQqBUeNyoGKWhBQO8m53A4UNSghQQCvk2A=";
    };
    vendorHash = "sha256-pY5m5ODRgqghyELRwwxOr+xlW41gtJWLXaW53GlLaFw=";
    subPackages = [ "cmd/bd" ];
    nativeCheckInputs = [ pkgs.git ];
  };
in
{
  home.packages = [ beads ];
}
