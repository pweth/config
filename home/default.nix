/*
* Home manager configuration entrypoint.
*/

{ config, home-manager, domain, host, keys, user, ... }:

{
  imports = [
    home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = {
      domain = domain;
      host = host;
      keys = keys;
      user = user;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = import ./home.nix;
  };
}
