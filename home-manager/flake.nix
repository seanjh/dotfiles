{
  description = "Home Manager configuration of sean";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
    {
      homeConfigurations = {
        donkey = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-darwin"; };
          modules = [
            ./modules/workstation.nix
            ./modules/common-darwin.nix
            ./hosts/host-donkey.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
        };

        flipper = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/workstation.nix
            ./modules/common-linux.nix
            ./hosts/host-flipper.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
        };

        bromeliad = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "armv7l-linux"; }; # Raspberry Pi 2
          modules = [
            ./modules/common-linux.nix
            ./hosts/host-bromeliad.nix
          ];
        };

        mosquito = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "armv6l-linux"; }; # Raspberry PI 1
          modules = [
            ./modules/common-linux.nix
            ./hosts/host-mosquito.nix
          ];
        };
      };
    };
}
