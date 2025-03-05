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
            ./modules/shared.nix
            ./modules/common-darwin.nix
            ./modules/host-donkey.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
        };

        flipper = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/shared.nix
            ./modules/common-linux.nix
            ./modules/host-flipper.nix
          ];
          extraSpecialArgs = { inherit nixpkgs-unstable; };
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
