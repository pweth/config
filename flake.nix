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
  
    # Secrets
    secrets.url = "git+ssh://git@github.com/pweth/secrets.git";
  };

  outputs = { self, nixpkgs, home-manager, agenix, secrets }@inputs: {
    # NixOS configurations
    nixosConfigurations = {
      # `sudo nixos-rebuild switch --flake .#chordata`
      chordata = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/chordata
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
        ];
        specialArgs = inputs;
        system = "x86_64-linux";
      };
    };
  };
}
