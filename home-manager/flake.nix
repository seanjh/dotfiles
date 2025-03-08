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
          pkgs = import nixpkgs { system = "x86_64-darwin"; }; # Macbook Air (Intel)
          modules = [
            ./modules/workstation.nix
            ./modules/common-darwin.nix
            ./hosts/host-donkey.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
        };

        flipper = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; }; # Windows WSL2
          modules = [
            ./modules/workstation.nix
            ./modules/common-linux.nix
            ./hosts/host-flipper.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
        };

        coontie = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "aarch64-linux"; }; # Raspberry Pi 4
          modules = [
            ./modules/common-linux.nix
            ./hosts/host-coontie.nix
          ];
        };
      };
    };
}
