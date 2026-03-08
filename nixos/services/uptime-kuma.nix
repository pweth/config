{ lib, ... }:

{
  # Service
  services.uptime-kuma.enable = true;
  systemd.services.uptime-kuma.serviceConfig.DynamicUser = lib.mkForce false;

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/uptime-kuma"
  ];

  # Virtual host
  services.nginx.virtualHosts."status.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/".proxyPass = "http://localhost:3001";
  };
}
