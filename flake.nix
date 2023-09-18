{
  description = "github.com/pweth/dotfiles";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";
  };

  outputs = { self, nixpkgs, home-manager, agenix }@inputs: {
    # NixOS configurations
    nixosConfigurations = {
      # `sudo nixos-rebuild switch --flake .#emperor`
      emperor = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/common
          ./hosts/common/gui.nix
          ./hosts/emperor
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
        specialArgs = inputs;
        system = "x86_64-linux";
      };

      # `sudo nixos-rebuild switch --flake .#macaroni`
      macaroni = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/macaroni
        ];
        specialArgs = inputs;
        system = "aarch64-linux";
      };
    };
  };
}
