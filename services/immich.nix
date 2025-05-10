/*
  * High performance self-hosted photo and video management solution.
  * https://github.com/immich-app/immich
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/immich";
in
{
  config = lib.mkIf (builtins.elem "immich" host.services) {
    modules.services.immich = {
      subdomain = "photos";

      mounts = {
        "${config.services.immich.mediaLocation}" = {
          hostPath = "${state}/app";
          isReadOnly = false;
        };
        "/var/lib/postgresql" = {
          hostPath = "${state}/database";
          isReadOnly = false;
        };
      };

      config = {
        i18n.defaultLocale = "en_GB.UTF-8";
        services.immich = {
          enable = true;
          port = config.modules.services.immich.port;
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state}/app 0770 999 999 -"
      "d ${state}/database 0770 999 999 -"
    ];
  };
}
