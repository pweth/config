# * Home manager module.

{
  config,
  lib,
  pkgs,
  domain,
  host,
  keys,
  user,
  version,
  ...
}:
let
  cfg = config.meta.home-manager;
in
{
  options.meta.home-manager.enable = lib.mkEnableOption "home manager";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];

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
      users."${user}" = import ../home;
    };
  };
}
