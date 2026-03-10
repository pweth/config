{ ... }:

{
  # Service
  services.uptime-kuma.enable = true;

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/private/uptime-kuma"
  ];

  # Virtual host
  services.nginx.virtualHosts."status.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/".proxyPass = "http://localhost:3001";
  };
}
