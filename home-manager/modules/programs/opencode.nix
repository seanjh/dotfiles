{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bleeding-edge.opencode
  ];

  home.file = {
    opencode-config = {
      target = "./.config/opencode/opencode.json";
      text = ''
        {
          "$schema": "https://opencode.ai/config.json",
          "plugin": [
            "opencode-openai-codex-auth@4.0.2"
          ]
        }
      '';
    };
  };
}
