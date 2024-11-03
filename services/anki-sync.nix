/*
* Self-hosted Anki sync server.
* https://docs.ankiweb.net/sync-server.html
*/

{ config, domain, user, ... }:
let
  subdomain = "anki.${domain}";
  port = 27751;
in
{
  age.secrets.anki.file = ../secrets/anki.age;

  services.anki-sync-server = {
    enable = true;
    port = port;
    users = [{
      username = user;
      passwordFile = config.age.secrets.anki.path;
    }];
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
}
