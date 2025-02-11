{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  baseDir = toString ./../..;
in
{
  home.packages = with pkgs; [
    xclip
  ];

  programs.bash = {
    shellAliases = {
      # clipboard copy
      cbc = "xclip -selection clipboard";
      # clipboard paste
      cbp = "xclip -selection clipboard -o";
    };
  };

  home.file = {
    ".config/git/config_linux".source = "${baseDir}/gitconfig-linux";
  };
}
