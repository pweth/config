{ config, lib, ... }:

{
  # Services
  services.nzbget.enable = true;
  services.prowlarr.enable = true;
  services.radarr.enable = true;
  services.sonarr.enable = true;
  systemd.services.prowlarr.serviceConfig.DynamicUser = lib.mkForce false;

  # Client group permissions
  users.groups.nzbget.members = [
    "radarr"
    "sonarr"
  ];

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/nzbget"
    config.services.prowlarr.dataDir
    config.services.radarr.dataDir
    config.services.sonarr.dataDir
  ];

  # Virtual hosts
  services.nginx.virtualHosts = {
    "prowlarr.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:9696";
    };
    "nzbget.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:6789";
    };
    "radarr.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:7878";
    };
    "sonarr.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:8989";
    };
  };
}
