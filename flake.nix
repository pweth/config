{
  description = "github:pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Hardware optimisation
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      agenix,
      home-manager,
      impermanence,
      nixos-hardware,
    }@inputs:
    let
      devices = import ./devices.nix;
      variables = {
        hosts = devices.hosts;
        keys = devices.keys;
        version = "24.11";
      };
    in
    {
      # `sudo nixos-rebuild switch --flake .#host`
      nixosConfigurations = builtins.mapAttrs (
        name: host:
        nixpkgs.lib.nixosSystem {
          modules = [
            (./hosts + "/${name}.nix")
            ./common
            ./modules
            agenix.nixosModules.default
            home-manager.nixosModules.default
            impermanence.nixosModules.impermanence
          ];
          specialArgs =
            inputs
            // variables
            // {
              host = host;
            };
          system = host.architecture;
        }
      ) devices.hosts;
    };
}
