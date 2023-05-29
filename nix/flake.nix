{
    description = "skovati nix flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in
    {
        nixosConfigurations = {
            think = nixpkgs.lib.nixosSystem {
                modules = [ ./configuration.nix ];
                specialArgs = { inherit inputs; };
            };
        };

        homeConfigurations = {
            skovati = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];
                extraSpecialArgs = { inherit inputs; };
            };
        };
    };
}
