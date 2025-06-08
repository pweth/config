{ config, lib, host, ... }:
let
  state = "/persist/data/usenet";
in
{
  config = lib.mkIf (builtins.elem "usenet" host.services) {
    modules.services.usenet = {
      subdomain = "media";

      mounts = {
        "/media" = {
          hostPath = "/persist/media";
          isReadOnly = false;
        };
        "/var/lib/nzbget" = {
          hostPath = "${state}/nzbget";
          isReadOnly = false;
        };
        "/var/lib/radarr" = {
          hostPath = "${state}/radarr";
          isReadOnly = false;
        };
        "/var/lib/sonarr" = {
          hostPath = "${state}/sonarr";
          isReadOnly = false;
        };
      };

      config = {
        services.nzbget.enable = true;
        services.radarr.enable = true;
        services.sonarr.enable = true;

        services.nginx.virtualHosts."${config.modules.services.usenet.subdomain}.pweth.com".locations = {
          "/".proxyPass = lib.mkForce "http://localhost:6789";
          "/radarr/".proxyPass = "http://localhost:7878";
          "/sonarr/".proxyPass = "http://localhost:8989";
        };

        users.groups.nzbget.members = [
          "radarr"
          "sonarr"
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state}/nzbget 0770 999 999 -"
      "d ${state}/radarr 0770 999 999 -"
      "d ${state}/sonarr 0770 999 999 -"
    ];
  };
}
