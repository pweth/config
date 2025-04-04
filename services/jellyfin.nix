/*
  * The free software media system.
  * https://github.com/jellyfin/jellyfin
*/

{ config, ... }:
let
  domain = "jellyfin.pweth.com";
in
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString 8096}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/certs/service.crt;
    sslCertificateKey = config.age.secrets.service.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [ config.services.jellyfin.dataDir ];
}
