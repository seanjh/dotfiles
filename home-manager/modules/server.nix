{
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}:
let
  baseDir = toString ./../..;
  unstablePkgs = import nixpkgs-unstable { system = pkgs.system; };
in
{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    curl
    btop
    iotop
    mtr
    ripgrep
    jq
    unzip
    vim
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  imports = [
    ./programs/bash.nix
    ./programs/fail2ban.nix
  ];

  programs.home-manager.enable = true;
}
