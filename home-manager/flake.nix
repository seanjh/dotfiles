{
  description = "Home Manager configuration of sean";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-ollama.url = "github:nixos/nixpkgs/d0169965cf1ce1cd68e50a63eabff7c8b8959743";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-ollama, ... }: {
    homeConfigurations = {
      donkey =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-darwin"; };
          modules = [
            ./modules/shared.nix
            ./modules/common-darwin.nix
            ./modules/host-donkey.nix
          ];
        };

      flipper =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/shared.nix
            ./modules/common-linux.nix
            ./modules/wsl.nix
            ./modules/host-flipper.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-ollama; };
        };

      "rbi" =
        let
          system = "aarch64-darwin";
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./modules/shared.nix
            ./modules/common-darwin.nix
            ./modules/host-rbi.nix
          ];
        };
    };
  };
}
