{
    description = "skovati nix conf";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { nixpkgs, home-manager, ... }@inputs:
    {
        nixosConfigurations = {
            think = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [ ./nix/configuration.nix ];
            };
        };

        homeConfigurations = {
            skovati = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                extraSpecialArgs = { inherit inputs; };
                modules = [ ./nix/home.nix ];
            };
        };
    };
}
