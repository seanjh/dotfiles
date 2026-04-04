{ pkgs, lib, ... }:

let
  version = "2.14.0";

  # Platform mapping for Render CLI releases
  platformMap = {
    "x86_64-linux" = {
      file = "cli_${version}_linux_amd64.zip";
      hash = lib.fakeSha256;
    };
    "aarch64-linux" = {
      file = "cli_${version}_linux_arm64.zip";
      hash = lib.fakeSha256;
    };
    "x86_64-darwin" = {
      file = "cli_${version}_darwin_amd64.zip";
      hash = lib.fakeSha256;
    };
    "aarch64-darwin" = {
      file = "cli_${version}_darwin_arm64.zip";
      # hash = "4ab8613dcb9fe106f8d31a1a02efd31edd1619e314107cae8804b5bda21870f8";
      # hash = "sha256-lsN8NQREk66VYC5A2ugglGP2ud9qfAKyPubuwvY8Bjs=";
      hash = "96c37c35044493ae95602e40dae8209463f6b9df6a7c02b23ee6eec2f63c063b";
    };
  };

  platformInfo =
    platformMap.${pkgs.stdenv.hostPlatform.system}
      or (throw "Unsupported platform: ${pkgs.stdenv.hostPlatform.system}");

  render-cli = pkgs.stdenv.mkDerivation rec {
    pname = "render-cli";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/render-oss/cli/releases/download/v${version}/${platformInfo.file}";
      sha256 = platformInfo.hash;
    };

    nativeBuildInputs = [ pkgs.unzip ];

    unpackPhase = ''
      runHook preUnpack
      unzip $src
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp ./cli_v${version} $out/bin/render
      chmod +x $out/bin/render
      runHook postInstall
    '';

    meta = with lib; {
      description = "CLI for Render, a unified cloud platform";
      homepage = "https://render.com/docs/cli";
      changelog = "https://github.com/render-oss/cli/releases/tag/v${version}";
      license = licenses.asl20;
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      maintainers = [ ];
    };
  };
in
{
  home.packages = [ render-cli ];
}
