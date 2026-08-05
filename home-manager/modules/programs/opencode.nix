{ pkgs, ... }:
let
  baseDir = toString ./../../..;
  opencodeDir = "${baseDir}/opencode";
  agentsDir = "${baseDir}/agents";
in
{
  home = {
    packages = with pkgs; [
      bleeding-edge.opencode
    ];

    file = {
      opencode-config = {
        target = ".config/opencode/opencode.jsonc";
        source = "${opencodeDir}/opencode.jsonc";
      };

      opencode-skill-docs = {
        target = ".config/opencode/skills/docs/SKILL.md";
        source = "${agentsDir}/skills/docs/SKILL.md";
      };

      opencode-command-shh = {
        target = ".config/opencode/commands/shh.md";
        source = "${agentsDir}/commands/shh.md";
      };

      opencode-command-plan-guide = {
        target = ".config/opencode/commands/plan-guide.md";
        source = "${agentsDir}/commands/plan-guide.md";
      };

      opencode-command-test-build = {
        target = ".config/opencode/commands/test-build.md";
        source = "${agentsDir}/commands/test-build.md";
      };
    };
  };
}
