# * Home manager configuration entrypoint.

{
  config,
  home-manager,
  domain,
  host,
  keys,
  user,
  version,
  ...
}:

{
  imports = [ home-manager.nixosModules.default ];

  home-manager = {
    extraSpecialArgs = {
      domain = domain;
      host = host;
      keys = keys;
      user = user;
      version = version;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = import ./home.nix;
  };
}
