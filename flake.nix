{
  description = "github.com/pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # SSH keys
    keys.url = "https://github.com/pweth.keys";
    keys.flake = false;

    # VSCode Server
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, agenix, home-manager, impermanence, keys, vscode-server }@inputs:
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
          hosts = hosts;
          host = host;
          user = "pweth";
        };
        system = host.architecture;
      }
    ) hosts;
  };
}
