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
  };

  outputs = { self, nixpkgs, agenix, home-manager }@inputs:
  let
    systems = {
      # Dell XPS 13 9360
      emperor = "x86_64-linux";

      # Dell OptiPlex 3050 Micro
      gentoo = "x86_64-linux";

      # Oracle VM.Standard.A1.Flex
      macaroni = "aarch64-linux";

      # Raspberry Pi Model 3B+
      rockhopper = "aarch64-linux";
    };
  in
  {
    # `sudo nixos-rebuild switch --flake .#host`
    nixosConfigurations = builtins.mapAttrs (
      name: value: nixpkgs.lib.nixosSystem {
        modules = [
          (./hosts + "/${name}")
          ./common
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs;
        system = value;
      }
    ) systems;
  };
}
