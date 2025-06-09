{
  description = "github:pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secret management
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";

    # Disk partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

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
      disko,
      home-manager,
      impermanence,
      nixos-hardware,
    }@inputs:
    let
      source = import ./census.nix;
      hosts = source.hosts;
      keys = source.keys;
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
            ./services
            agenix.nixosModules.default
            disko.nixosModules.disko
            home-manager.nixosModules.default
            impermanence.nixosModules.impermanence
          ];
          specialArgs =
            inputs
            // {
              host = host;
              hosts = hosts;
              keys = keys;
            };
          system = host.architecture;
        }
      ) hosts;
    };
}
