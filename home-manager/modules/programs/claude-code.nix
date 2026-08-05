{
  pkgs,
  ...
}:
let
  baseDir = toString ./../../..;
  agentsDir = "${baseDir}/agents";
in
{
  home.file = {
    claude-command-concise = {
      target = ".claude/commands/shh.md";
      source = "${agentsDir}/commands/shh.md";
    };

    claude-skill-docs = {
      target = ".claude/skills/docs/SKILL.md";
      source = "${agentsDir}/skills/docs/SKILL.md";
    };

    claude-command-plan-guide = {
      target = ".claude/commands/plan-guide.md";
      source = "${agentsDir}/commands/plan-guide.md";
    };

    claude-command-test-build = {
      target = ".claude/commands/test-build.md";
      source = "${agentsDir}/commands/test-build.md";
    };
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.bleeding-edge.claude-code;

    settings = {
      permissions = {
        defaultMode = "default";
        allow = [
          "WebSearch"
          "Bash(gh:*)"
          "Bash(git:*)"
          "Bash(gt:*)"
          "Bash(grep:*)"
          "Bash(rg:*)"
          "Bash(find:*)"
          "Bash(fd:*)"
          "Bash(mkdir:*)"
          "Bash(echo:*)"
          "Bash(bd:*)"
          "Bash(head:*)"
          "Bash(tail:*)"
          "Bash(sed:*)"
          "Bash(awk:*)"
          "WebFetch(domain:github.com)"
          "WebFetch(domain:raw.githubusercontent.com)"
          "WebFetch(domain:api.github.com)"
          "WebFetch(domain:docs.claude.com)"
        ];
        deny = [ ];
        ask = [
          "Bash(mv:*)"
          "Bash(rm:*)"
          "Bash(chmod:*)"
        ];
        additionalDirectories = [ "~/.claude/plans" ];
      };

      enabledPlugins = {
        "explanatory-output-style@claude-plugins-official" = true;
        "github@claude-plugins-official" = false;
        "hookify@claude-plugins-official" = false;
        "learning-output-style@claude-plugins-official" = true;
        "security-guidance@claude-plugins-official" = true;
        "code-review@claude-plugins-official" = true;
      };

      extraKnownMarketplaces = {
      };

      alwaysThinkingEnabled = true;

      prompt = "";

      hooks = { };
    };
  };
}
