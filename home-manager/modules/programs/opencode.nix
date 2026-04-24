{ pkgs, ... }:
let
  baseDir = toString ./../../..;
  opencodeDir = "${baseDir}/opencode";
  agentsDir = "${baseDir}/agents";
in
{
  home.packages = with pkgs; [
    bleeding-edge.opencode
  ];

  home.file.opencode-config = {
    target = ".config/opencode/opencode.jsonc";
    source = "${opencodeDir}/opencode.jsonc";
  };

  home.file.opencode-skill-docs = {
    target = ".config/opencode/skills/docs/SKILL.md";
    source = "${agentsDir}/skills/docs/SKILL.md";
  };

  home.file.opencode-command-shh = {
    target = ".config/opencode/commands/shh.md";
    source = "${agentsDir}/commands/shh.md";
  };

  home.file.opencode-command-plan-guide = {
    target = ".config/opencode/commands/plan-guide.md";
    source = "${agentsDir}/commands/plan-guide.md";
  };
}
