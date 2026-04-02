{
  pkgs,
  ...
}:
let
  baseDir = toString ./../../..;
  claudeCodeDir = "${baseDir}/claude-code";
in
{
  home.packages = with pkgs; [
    unstable.beads
  ];

  home.file = {
    claude-statusline = {
      target = ".claude/statusline.sh";
      source = "${baseDir}/scripts/claude-statusline.sh";
      executable = true;
    };

    claude-command-concise = {
      target = ".claude/commands/shh.md";
      source = "${claudeCodeDir}/commands/shh.md";
    };

    claude-skill-ref = {
      target = ".claude/skills/ref/SKILL.md";
      source = "${claudeCodeDir}/skills/ref/SKILL.md";
    };

    claude-command-beads = {
      target = ".claude/commands/plan-to-beads.md";
      source = "${
        pkgs.fetchFromGitHub {
          owner = "steveyegge";
          repo = "beads";
          rev = "e3b9e86c4abc9fa759319b0fca0573600b07e732";
          sha256 = "sha256-YFIH2xk32ClW3bJ1zH/dS2Uz7IwzzLT48NNFByKWaF4=";
        }
      }/integrations/claude-code/commands/plan-to-beads.md";
    };

    claude-command-plan-guide = {
      target = ".claude/commands/plan-guide.md";
      source = "${claudeCodeDir}/commands/plan-guide.md";
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
          "mcp__context7__resolve-library-id"
          "mcp__context7__get-library-docs"
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
        "beads@beads-marketplace" = true;
        "context7@claude-plugins-official" = true;
        "explanatory-output-style@claude-plugins-official" = true;
        "github@claude-plugins-official" = false;
        "hookify@claude-plugins-official" = false;
        "learning-output-style@claude-plugins-official" = true;
        "security-guidance@claude-plugins-official" = true;
        "ralph-wiggum@claude-plugins-official" = true;
        "code-review@claude-plugins-official" = true;
      };

      extraKnownMarketplaces = {
        beads-marketplace = {
          source = {
            source = "git";
            url = "https://github.com/steveyegge/beads.git";
          };
        };
      };

      alwaysThinkingEnabled = true;

      statusLine = {
        type = "command";
        command = "~/.claude/statusline.sh";
      };

      # beads specific
      # via https://github.com/steveyegge/beads/blob/main/docs/INSTALLING.md
      prompt = ''
        Before starting any work, run 'bd onboard' to understand the current project state and available issues.
      '';

      hooks = {
        PreCompact = [
          {
            hooks = [
              {
                command = "bd prime --stealth";
                type = "command";
              }
            ];
            matcher = "";
          }
        ];
        SessionStart = [
          {
            hooks = [
              {
                command = "bd prime --stealth";
                type = "command";
              }
            ];
            matcher = "";
          }
        ];
      };
    };
  };
}
