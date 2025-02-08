{
  config,
  pkgs,
  lib,
  nixpkgs-unstable,
  ...
}:
let
  unstablePkgs = import nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  libPaths = lib.makeLibraryPath [
    "/usr/lib/wsl"
    "${pkgs.cudaPackages.cudatoolkit}"
  ];
in
{
  nixpkgs.config.allowUnfree = true;
  home.username = "sean";
  home.homeDirectory = "/home/sean";

  home.packages = with pkgs; [
    unstablePkgs.ollama
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
      ExecStart = "${unstablePkgs.ollama}/bin/ollama serve";
      Restart = "always";
      Environment = "LD_LIBRARY_PATH=${libPaths}";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
