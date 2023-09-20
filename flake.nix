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

    # VSCode server
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, home-manager, agenix, vscode-server }@inputs: {
    # NixOS configurations
    nixosConfigurations = {
      # `sudo nixos-rebuild switch --flake .#emperor`
      emperor = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/common
          ./hosts/common/gui.nix
          ./hosts/emperor
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs;
        system = "x86_64-linux";
      };

      # `sudo nixos-rebuild switch --flake .#macaroni`
      macaroni = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/common
          ./hosts/macaroni
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default
        ];
        specialArgs = inputs;
        system = "aarch64-linux";
      };

      # `sudo nixos-rebuild switch --flake .#rockhopper`
      rockhopper = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/common
          ./hosts/rockhopper
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = inputs;
        system = "aarch64-linux";
      };
    };
  };
}
