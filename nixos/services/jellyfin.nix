{ config, lib, ... }:

{
  # Service
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Requests manager
  services.jellyseerr.enable = true;
  systemd.services.jellyseerr.serviceConfig.DynamicUser = lib.mkForce false;

  # State
  environment.persistence."/persist".directories = [
    config.services.jellyfin.cacheDir
    config.services.jellyfin.dataDir
    config.services.jellyseerr.configDir
  ];

  # Virtual hosts
  services.nginx.virtualHosts = {
    "jellyfin.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:8096";
    };
    "requests.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:${toString config.services.jellyseerr.port}";
    };
  };
}
