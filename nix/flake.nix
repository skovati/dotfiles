{
    description = "skovati nix flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... } @inputs:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
                modules = [ ./home.nix ];
                inherit pkgs;
                extraSpecialArgs = { inherit inputs; };
            };
        };

        devShells.${system}.default = pkgs.mkShell {
            buildInputs = with pkgs; [
                nix
                home-manager
                git
            ];
        };
    };
}
