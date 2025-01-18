{ config, pkgs, ... }:
{
  home.username = "sean";
  home.homeDirectory = "/Users/sean";

  home.packages = with pkgs; [
    (ollama.override {
      version = "0.5.7";
      src = fetchFromGitHub {
        owner = "ollama";
        repo = "ollama";
        rev = "v${version}";
        hash = "sha256-a420a453b4783841e3e79c248ef0fe9548df6914";
      };
      buildInputs = [ cuda cudaPackages.cudnn ];
    })
    cudaPackages.cuda_nvcc
    cudaPackages.cudnn
  ];

  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama AI Service";
      After = [ "network.target" ];
    };
    Service = {
      Environment = "PATH=/run/current-system/sw/bin";
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
