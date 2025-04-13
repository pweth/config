/*
  * High performance self-hosted photo and video management solution.
  * https://github.com/immich-app/immich
*/

{ config, lib, host, ... }:
let
  domain = host.services.immich or null;
in
{
  config = lib.mkIf (domain != null) {
    # Service configuration
    services.immich.enable = true;

    # Internal domain
    services.nginx.virtualHosts."${domain}" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.immich.port}";
        proxyWebsockets = true;
      };
      sslCertificate = ../static/certs/service.crt;
      sslCertificateKey = config.age.secrets.service.path;
    };
  };
}
