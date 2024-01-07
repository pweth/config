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

  outputs = { self, nixpkgs, agenix, home-manager }@inputs: {
    # NixOS configurations
    nixosConfigurations = {
      # `sudo nixos-rebuild switch --flake .#emperor`
      emperor = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/emperor
          ./common
          ./common/gui.nix
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs;
        system = "x86_64-linux";
      };

      # `sudo nixos-rebuild switch --flake .#macaroni`
      macaroni = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/macaroni
          ./common
          ./common/ssh.nix
          ./services
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs;
        system = "aarch64-linux";
      };

      # `sudo nixos-rebuild switch --flake .#rockhopper`
      rockhopper = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/rockhopper
          ./common
          ./common/ssh.nix
          agenix.nixosModules.default
        ];
        specialArgs = inputs;
        system = "aarch64-linux";
      };
    };
  };
}
