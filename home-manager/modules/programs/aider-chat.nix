{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat-full
    # aider-chat.withOptional { withPlaywright = true; withBrowser = true; }
    # unstable.aider-chat.withOptional
    # {
    #   withPlaywright = true;
    #   withBrowser = true;
    #   withHelp = true;
    # }
  ];

  home.file = {
    aider-chat = {
      target = ".aider.conf.yml";
      text = ''
        dark-mode: false
        watch-files: true
        check-update: false
        show-release-notes: false
        gitignore: false
        vim: true
        multiline: true
        alias:
          - "claude:anthropic/claude-3-5-sonnet-latest"
          - "claude35:anthropic/claude-3-7-sonnet-latest"
          - "claude37:anthropic/claude-3-7-sonnet-latest"
          - "claude-small:anthropic/claude-3-5-haiku-latest"
          - "gpt:openai/gpt-4o"
          - "gpt-smart:o3-mini"
          - "gpt-small:openai/gpt-4o-mini"
          - "local:ollama_chat/qwen2.5-coder"
      '';
    };
  };
}
