/*
  * The free software media system.
  * https://github.com/jellyfin/jellyfin
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/jellyfin";
in
{
  config = lib.mkIf (host.services.jellyfin or null != null) {
    modules.services.jellyfin = {
      subdomain = host.services.jellyfin;
      address = "192.168.1.7";
      port = 8096;
      tag = "shared";

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
      "d ${state} 0770 root root -"
    ];
  };
}
