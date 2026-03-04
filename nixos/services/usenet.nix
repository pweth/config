{ config, ... }:

{
  # Services
  services.nzbget.enable = true;
  services.radarr.enable = true;
  services.sonarr.enable = true;

  # Client group permissions
  users.groups.nzbget.members = [
    "radarr"
    "sonarr"
  ];

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/nzbget"
    config.services.radarr.dataDir
    config.services.sonarr.dataDir
  ];

  # Virtual host
  services.nginx.virtualHosts = {
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
