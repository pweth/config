{ config, ... }:

{
  # Service
  services.immich.enable = true;

  # State
  environment.persistence."/persist".directories = [
    config.services.immich.mediaLocation
    config.services.postgresql.dataDir
  ];

  # Virtual host
  services.nginx.virtualHosts."photos.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.immich.port}";
      proxyWebsockets = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
        send_timeout 600s;
      '';
    };
  };
}
