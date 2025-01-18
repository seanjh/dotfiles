{ config, pkgs, nixpkgs-ollama, ... }:
let
  ollamaPkgs = import nixpkgs-ollama {
    system = pkgs.system;
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
in
{
  nixpkgs.config.allowUnfree = true;
  home.username = "sean";
  home.homeDirectory = "/home/sean";

  home.packages = [
    ollamaPkgs.ollama
    pkgs.cudaPackages.cuda_nvcc
    pkgs.cudaPackages.cuda_cudart
  ];
}
