{ inputs, pkgs, stable-pkgs, ... }: {
    skovati = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs stable-pkgs; };
    };
}
