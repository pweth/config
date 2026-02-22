{ config, ... }:

{
  # Service
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # State
  environment.persistence."/persist".directories = [
    config.services.jellyfin.dataDir
  ];

  # Virtual host
  services.nginx.virtualHosts."jellyfin.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/".proxyPass = "http://localhost:8096";
  };
}
