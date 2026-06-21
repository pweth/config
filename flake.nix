{
  description = "github:pweth/config";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Nix darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-26.05";
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

  outputs =
    inputs@{ nixpkgs, nix-darwin, ... }:
    {
      # `sudo darwin-rebuild switch --flake .`
      darwinConfigurations.laptop = nix-darwin.lib.darwinSystem {
        modules = [
          ./common
          ./darwin
        ];
        specialArgs = {
          inherit inputs;
          host = {
            name = "laptop";
            architecture = "aarch64-darwin";
          };
        };
      };

      # `sudo nixos-rebuild switch --flake .`
      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        modules = [
          ./common
          ./nixos
        ];
        specialArgs = {
          inherit inputs;
          host = {
            name = "homelab";
            architecture = "x86_64-linux";
          };
        };
      };

      # `nix fmt` (RFC style)
      formatter = nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-linux" ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-tree
      );
    };
}
