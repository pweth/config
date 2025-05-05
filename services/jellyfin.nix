/*
  * The free software media system.
  * https://github.com/jellyfin/jellyfin
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/jellyfin";
in
{
  config = lib.mkIf (builtins.elem "jellyfin" host.services) {
    modules.services.jellyfin = {
      port = 8096;

      mounts = {
        "${config.services.jellyfin.dataDir}" = {
          hostPath = state;
          isReadOnly = false;
        };
        "/media".hostPath = "/persist/media";
      };

      config.services.jellyfin = {
        enable = true;
        openFirewall = true;
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
