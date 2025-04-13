/*
  * The free software media system.
  * https://github.com/jellyfin/jellyfin
*/

{ config, lib, host, ... }:
let
  domain = host.services.jellyfin or null;
in
{
  config = lib.mkIf (domain != null) {
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
  };
}
