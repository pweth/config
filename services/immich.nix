/*
  * High performance self-hosted photo and video management solution.
  * https://github.com/immich-app/immich
*/

{ config, lib, host, ... }:
let
  domain = "photos.pweth.com";
in
{
  config = lib.mkIf (builtins.elem "immich" host.services) {
    # Service configuration
    services.immich.enable = true;

    # Internal domain
    services.nginx.virtualHosts."${domain}" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.immich.port}";
        proxyWebsockets = true;
      };
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };
}
