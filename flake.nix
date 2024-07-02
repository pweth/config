{
  description = "github:pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Hardware optimisation
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # VSCode server
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, agenix, home-manager, impermanence, nixos-hardware, vscode-server }@inputs:
  let
    hosts = builtins.fromTOML (builtins.readFile ./hosts.toml);
  in
  {
    # `sudo nixos-rebuild switch --flake .#host`
    nixosConfigurations = builtins.mapAttrs (
      name: host: nixpkgs.lib.nixosSystem {
        modules = [
          (./hosts + "/${name}.nix")
          (./hardware + "/${host.system}.nix")
          ./common
          agenix.nixosModules.default
          home-manager.nixosModules.default
          impermanence.nixosModules.impermanence
          vscode-server.nixosModules.default
        ];
        specialArgs = inputs // {
          domain = "pweth.com";
          host = host;
          hosts = hosts;
          user = "pweth";
        };
        system = host.architecture;
      }
    ) hosts;
  };
}
