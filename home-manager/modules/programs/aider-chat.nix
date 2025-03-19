{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    unstable.aider-chat
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
          - "fast:gpt-4o-mini"
          - "smart:o3-mini"
          - "hacker:claude-3-sonnet-20240229"
          - "local:ollama_chat/qwen2.5-coder"
      '';
    };
  };
}
