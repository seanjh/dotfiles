{
  pkgs,
  ...
}:
let
  baseDir = toString ./../../..;
in
{
  home.file = {
    claude-statusline = {
      target = ".claude/statusline.sh";
      source = "${baseDir}/scripts/claude-statusline.sh";
      executable = true;
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
      text = ''
        ---
        description: Walk through an existing plan
        model: claude-sonnet-4-5-20250929
        ---

        You will guide me through the completed plan step-by-step, but WILL NOT directly edit and files or write any code, unless I explicitly ask you to do so. Instead, I will be entering all code changes. You are responsible for guiding me through the plan, while I manually enter all code changes.

        Guidelines:

        - DO scrutinize my changes for correctness, idioms, and best practices
        - DO provide feedback on better, simpler alternative solutions
        - DO review changes for cohesion, SOLID principles, and correctness
        - DO provide additional learning and instructive context, to promote learning
        - DO NOT edit code unless I explicitly ask you to do so
      '';
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
          "Bas(head:*)"
          "Bas(tail:*)"
          "Bas(sed:*)"
          "Bas(awk:*)"
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
        additionalDirectories = [ ];
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
    };
  };
}
