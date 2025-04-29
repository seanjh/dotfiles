# via https://github.com/NixOS/nixpkgs/blob/30876db20b68252b900ee77a622ac3d88ca881fb/pkgs/by-name/co/codex/package.nix
final: prev:
let
  src = prev.fetchFromGitHub {
    owner = "openai";
    repo = "codex";
    rev = "f3f9e41a155539b3fb97267d5f842dc57d99d83f";
    hash = "sha256-auWa2x68AiJeF/2PNTByng97f6k8yBqSD4HPgIHcJtU=";
  };
in
{
  npm-openai-codex = prev.buildNpmPackage {
    pname = "codex";
    version = "0.1.2504161510"; # from codex-cli/package.json

    inherit src;

    sourceRoot = "${src.name}/codex-cli";

    npmDepsHash = "sha256-riVXC7T9zgUBUazH5Wq7+MjU1FepLkp9kHLSq+ZVqbs=";

    meta = {
      description = "Lightweight coding agent that runs in your terminal";
      homepage = "https://github.com/openai/codex";
      mainProgram = "codex";
    };
  };
}
