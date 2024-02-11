{
  description = "github.com/pweth/dotfiles";

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

    # SSH keys
    keys.url = "https://github.com/pweth.keys";
    keys.flake = false;
  };

  outputs = { self, nixpkgs, agenix, home-manager, keys }@inputs:
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
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs // {
          hostName = name;
          hosts = hosts;
          host = host;
        };
        system = host.arch;
      }
    ) hosts;
  };
}
