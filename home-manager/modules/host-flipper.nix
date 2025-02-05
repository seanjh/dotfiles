{
  config,
  pkgs,
  lib,
  nixpkgs-ollama,
  ...
}:
let
  ollamaPkgs = import nixpkgs-ollama {
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
    ollamaPkgs.ollama
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
      ExecStart = "${ollamaPkgs.ollama}/bin/ollama serve";
      Restart = "always";
      Environment = "LD_LIBRARY_PATH=${libPaths}";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
