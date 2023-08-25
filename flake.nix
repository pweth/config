{
  description = "github.com/pweth/dotfiles";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # NixOS configurations
    # `sudo nixos-rebuild switch --flake .#chordata`
    nixosConfigurations = {
      "chordata" = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/chordata
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.pweth = import ./home
          # }
        ];
        specialArgs = inputs;
        system = "x86_64-linux";
      };
    };
  };
}
