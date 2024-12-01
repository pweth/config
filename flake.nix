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

  outputs = { self, nixpkgs, agenix, home-manager, impermanence, nixos-hardware }@inputs:
  let
    hosts = builtins.fromTOML (builtins.readFile ./attrs/hosts.toml);
    keys = builtins.fromTOML (builtins.readFile ./attrs/keys.toml);
  in
  {
    # `sudo nixos-rebuild switch --flake .#host`
    nixosConfigurations = builtins.mapAttrs (
      name: host: nixpkgs.lib.nixosSystem {
        modules = [
          (./hosts + "/${name}.nix")
          ./common
          agenix.nixosModules.default
        ];
        specialArgs = inputs // {
          domain = "pweth.com";
          host = host;
          hosts = hosts;
          keys = keys;
          user = "pweth";
        };
        system = host.architecture;
      }
    ) hosts;
  };
}
