{
  pkgs,
  lib,
  ...
}:
let
  baseDir = toString ./../../..;
in
{
  home.file.claude-statusline = {
    target = ".claude/statusline.sh";
    source = "${baseDir}/scripts/claude-statusline.sh";
    executable = true;
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.bleeding-edge.claude-code;

    settings = {
      permissions = {
        defaultMode = "plan";
        allow = [
          "WebSearch"
          "Bash(gh:*)"
          "Bash(gt:*)"
          "Bash(grep:*)"
          "Bash(find:*)"
          "Bash(mkdir:*)"
          "Bash(echo:*)"
          "Bash(mv:*)"
          "Bash(rm:*)"
          "Bash(chmod:*)"
          "WebFetch(domain:github.com)"
          "WebFetch(domain:raw.githubusercontent.com)"
          "WebFetch(domain:api.github.com)"
          "WebFetch(domain:docs.claude.com)"
          "mcp__context7__resolve-library-id"
          "mcp__context7__get-library-docs"
        ];
        deny = [ ];
        ask = [ ];
        additionalDirectories = [
          "/Users/sean/work/sage-ios/"
        ];
      };
      enabledPlugins = {
        "context7@claude-plugins-official" = true;
        "explanatory-output-style@claude-plugins-official" = true;
        "github@claude-plugins-official" = false;
        "hookify@claude-plugins-official" = false;
        "learning-output-style@claude-plugins-official" = true;
        "security-guidance@claude-plugins-official" = true;
        "ralph-wiggum@claude-plugins-official" = true;
      };
      alwaysThinkingEnabled = true;
      # statusLine = {
      #   type = "command";
      #   command = "~/.claude/statusline.sh";
      # };
    };
  };
}
