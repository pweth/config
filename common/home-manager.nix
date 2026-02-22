{ inputs, pkgs, ... }:

{
  # Package
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pweth = import ./home;
  };
}
