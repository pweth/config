/*
  * Self-hosted Anki sync server.
  * https://docs.ankiweb.net/sync-server.html
*/

{ config, ... }:
let
  domain = "anki.pweth.com";
in
{
  age.secrets.anki.file = ../secrets/anki.age;

  services.anki-sync-server = {
    enable = true;
    users = [
      {
        username = "pweth";
        passwordFile = config.age.secrets.anki.path;
      }
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString config.services.anki-sync-server.port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/certs/service.crt;
    sslCertificateKey = config.age.secrets.service.path;
  };
}
