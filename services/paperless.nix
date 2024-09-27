/*
* Scan, index and archive all your physical documents.
* https://github.com/paperless-ngx/paperless-ngx
*/

{ config, domain, ... }:
let
  subdomain = "docs.${domain}";
  port = 36095;
in
{
  # Admin password
  age.secrets.paperless = {
    file = ../secrets/paperless.age;
    owner = "paperless";
  };

  # Service configuration
  services.paperless = {
    enable = true;
    address = "127.0.0.1";
    passwordFile = config.age.secrets.paperless.path;
    port = port;
    settings = {
      PAPERLESS_APP_TITLE = "Paperless";
      PAPERLESS_DATE_ORDER = "DMY";
    };
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
  environment.persistence."/persist".directories = [ "/var/lib/paperless" ];
}
