{
  description = "Home Manager configuration of sean";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-bleeding-edge.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-bleeding-edge,
      ...
    }:
    let
      unstableOverlay = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (prev.stdenv.hostPlatform) system;
          inherit (prev) config;
        };
      };
      bleedingEdgeOverlay = final: prev: {
        bleeding-edge = import nixpkgs-bleeding-edge {
          inherit (prev.stdenv.hostPlatform) system;
          inherit (prev) config;
        };
      };
      # NOTE: (sean) temporary
      # direnv 2.37.1 fish test suite is SIGKILL'd on aarch64-darwin due to
      # a broken code signature on the Hydra-built fish binary (nixpkgs#507531)
      direnvOverlay = final: prev: {
        direnv = prev.direnv.overrideAttrs (_: {
          checkPhase = "";
        });
      };
      overlays = [
        unstableOverlay
        bleedingEdgeOverlay
        direnvOverlay
      ];

    in
    {
      homeConfigurations = {
        # Macbook Air (Intel)
        donkey = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit overlays;
            system = "x86_64-darwin";
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
            inherit overlays;
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
            inherit overlays;
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
            inherit overlays;
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
