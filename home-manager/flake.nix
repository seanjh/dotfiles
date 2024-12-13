{
  description = "Home Manager configuration of sean";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      donkey = let
        system = "x86_64-darwin";
      in home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          ./modules/shared.nix
          ./modules/common-darwin.nix
          ./modules/host-donkey.nix
        ];
      };

      flipper = let
        system = "x86_64-linux";
      in home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          ./modules/shared.nix
          ./modules/common-linux.nix
          ./modules/host-flipper.nix
        ];
      };

      "rbi" = let
        system = "aarch64-darwin";
      in home-manager.lib.homeManagerConfiguration {
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
