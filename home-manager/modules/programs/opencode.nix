{ pkgs, ... }:
let
  json = pkgs.formats.json { };
in
{
  home.packages = with pkgs; [
    bleeding-edge.opencode
  ];

  home.file.opencode-config = {
    target = ".config/opencode/opencode.jsonc";
    source = json.generate "opencode.json" {
      autoupdate = false;
      plugin = [ "opencode-openai-codex-auth@909adb7" ];
      mcp = {
        context7 = {
          type = "local";
          enabled = true;
          command = "npx";
          args = [
            "-y"
            "@upstash/context7-mcp"
          ];
          environment = {
            CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
          };
        };
      };
    };
  };
}
