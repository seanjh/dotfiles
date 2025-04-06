{
  description = "Home Manager configuration of sean";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/06b40679c67ac240b6a034d2cbeeeb821947fe3c";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      unstableOverlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.system;
          config = prev.config;
        };
      };
    in
    {
      homeConfigurations = {
        # Macbook Air (Intel)
        donkey = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-darwin";
            overlays = [ unstableOverlay ];
            config = {
              allowUnfree = true;
            };
          };
          modules = [
            ./modules/workstation.nix
            ./modules/common-darwin.nix
            ./hosts/host-donkey.nix
          ];
        };

        # Windows WSL2
        flipper = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ unstableOverlay ];
            config = {
              allowUnfree = true;
              cudaSupport = true;
            };
          };
          modules = [
            ./modules/workstation.nix
            ./modules/common-linux.nix
            ./hosts/host-flipper.nix
          ];
        };

        # Raspberry Pi 4
        coontie = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            overlays = [ unstableOverlay ];
          };
          modules = [
            ./modules/server.nix
            ./modules/common-linux.nix
            ./hosts/host-coontie.nix
          ];
        };

        # Macbook Pro 2025
        clara = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            overlays = [ unstableOverlay ];
            config = {
              allowUnfree = true;
            };
          };
          modules = [
            ./modules/workstation.nix
            ./modules/common-darwin.nix
            ./hosts/host-clara.nix
          ];
        };
      };
    };
}
