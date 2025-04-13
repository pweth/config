# * Home manager module.

{
  config,
  lib,
  pkgs,
  host,
  keys,
  version,
  ...
}:
let
  cfg = config.modules.home-manager;
in
{
  options.modules.home-manager.enable = lib.mkEnableOption "home manager";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];

    home-manager = {
      extraSpecialArgs = {
        host = host;
        keys = keys;
        version = version;
      };
      useGlobalPkgs = true;
      useUserPackages = true;
      users.pweth = import ../home;
    };
  };
}
