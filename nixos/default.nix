{ inputs, ... }: {
    think = inputs.nixpkgs.lib.nixosSystem {
        modules = [
            ./configuration.nix
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
        ];
        specialArgs = { inherit inputs; };
    };
}
