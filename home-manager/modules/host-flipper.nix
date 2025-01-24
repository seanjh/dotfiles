{ config, pkgs, nixpkgs-ollama, ... }:
let
  ollamaPkgs = import nixpkgs-ollama {
    system = pkgs.system;
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  ldLibraryPath = "/usr/lib/wsl/lib:${pkgs.cudaPackages.cudatoolkit}/lib";
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

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${ldLibraryPath}:$LD_LIBRARY_PATH";
  };

  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${ollamaPkgs.ollama}/bin/ollama serve";
      Restart = "always";
      Environment = "LD_LIBRARY_PATH=${ldLibraryPath}";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
