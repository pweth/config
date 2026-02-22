{
  description = "github:pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Nix darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secret management
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "nixpkgs";

    # Disk partitioning
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Hardware optimisation
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ nixpkgs, nix-darwin, ... }:
    {
      # `sudo darwin-rebuild switch --flake .`
      darwinConfigurations.adelie = nix-darwin.lib.darwinSystem {
        modules = [
          ./common
          ./darwin
        ];
        specialArgs = {
          inherit inputs;
          host = {
            architecture = "aarch64-darwin";
            name = "adelie";
            species = "Pygoscelis adeliae";
          };
        };
      };

      # `sudo nixos-rebuild switch --flake .`
      nixosConfigurations.macaroni = nixpkgs.lib.nixosSystem {
        modules = [
          ./common
          ./nixos
        ];
        specialArgs = {
          inherit inputs;
          host = {
            architecture = "x86_64-linux";
            name = "macaroni";
            species = "Eudyptes chrysolophus";
            ssh-key = builtins.readFile ./static/ed25519.pub;
          };
          keys = builtins.fromTOML (builtins.readFile ./static/keys.toml);
        };
      };
    };
}
