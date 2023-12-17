{
    description = "skovati nix flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... } @inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        stable-pkgs = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations = ( import ./nixos { inherit inputs pkgs; } );
        homeConfigurations = ( import ./home { inherit inputs pkgs stable-pkgs; } );
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                pkgs.nix
                pkgs.home-manager
                pkgs.git
            ];
        };
    };
}
