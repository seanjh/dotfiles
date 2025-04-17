final: prev:
let
  buildNpmPackage =
    prev.callPackage prev.path + "/pkgs/development/web/nodejs/node-packages/node-build.nix" { };
  src = prev.fetchFromGitHub {
    owner = "openai";
    repo = "codex";
    rev = "f3f9e41a155539b3fb97267d5f842dc57d99d83f";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
{
  npm-openai-codex = buildNpmPackage {
    pname = "codex";
    version = "0.1.2504161510"; # from codex-cli/package.json

    sourceRoot = "${src}/codex-cli";

    npmDepsHash = "sha256-QdfO/p8oQnwIANeNRD0vD55v5lc9dHeaScpnpLqWdxc=";

    meta = {
      description = "Lightweight coding agent that runs in your terminal";
      homepage = "https://github.com/openai/codex";
      license = prev.lib.licenses.asl20;
      mainProgram = "codex";
    };

  };
}
