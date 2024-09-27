/*
* The free software media system.
* https://github.com/jellyfin/jellyfin
*/

{ config, domain, ... }:
let
  subdomain = "jellyfin.${domain}";
  port = 8096;
in
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [ "/var/lib/jellyfin" ];
}
