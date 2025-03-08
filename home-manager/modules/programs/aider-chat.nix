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
        watch-files: true
        analytics-disable: true
        check-update: false
        vim: true
        multiline: true
      '';
    };
  };
}
