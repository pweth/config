{ config, ... }:

{
  # Admin token
  age.secrets.vaultwarden = {
    file = ../agenix/vaultwarden.age;
    mode = "004";
  };

  # Service
  services.vaultwarden = {
    enable = true;
    environmentFile = config.age.secrets.vaultwarden.path;
    config = {
      domain = "https://vault.intranet.london";
      rocketAddress = "127.0.0.1";
      rocketPort = 8222;
      signupsAllowed = false;
    };
  };

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/vaultwarden"
  ];

  # Virtual host
  services.nginx.virtualHosts."vault.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.vaultwarden.config.rocketPort}";
      proxyWebsockets = true;
    };
  };
}
