{
  config,
  pkgs,
  lib,
  ...
}:
let
  libPaths = lib.makeLibraryPath [
    "/usr/lib/wsl"
    "${pkgs.cudaPackages.cudatoolkit}"
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  home.username = "sean";
  home.homeDirectory = "/home/sean";

  home.sessionVariables = {
    DISPLAY = ":0"; # for X11 / xclip in WSL
  };

  home.packages = with pkgs; [
    unstable.ollama
    cudaPackages.cuda_nvcc
    cudaPackages.cuda_cudart
    cudaPackages.cudatoolkit
  ];

  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.unstable.ollama}/bin/ollama serve";
      Restart = "always";
      Environment = [ "LD_LIBRARY_PATH=${libPaths}" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
