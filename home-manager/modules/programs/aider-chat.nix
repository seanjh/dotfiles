{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.aider-chat.withPlaywright
  ];

  home.file = {
    aider-chat = {
      target = ".aider.conf.yml";
      text = ''
        dark-mode: false
        watch-files: true
        check-update: false
        gitignore: false
        vim: true
        multiline: true
        alias:
          - "fast:openai/gpt-4o-mini"
          - "smart:o3-mini"
          - "code:anthropic/claude-3-7-sonnet-latest"
          - "code-gpt:openai/gpt-4o"
          - "local:ollama_chat/qwen2.5-coder"
      '';
    };
  };
}
