/*
* Scan, index and archive all your physical documents.
* https://github.com/paperless-ngx/paperless-ngx
*/

{ config, lib, domain, host, ... }:
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
    address = "0.0.0.0";
    extraConfig = {
      PAPERLESS_APP_TITLE = "Paperless";
      PAPERLESS_DATE_ORDER = "DMY";
    };
    passwordFile = config.age.secrets.paperless.path;
    port = port;
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/misc/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };

  # Persist service data
  environment.persistence = lib.mkIf host.impermanent {
    "/persist".directories = [ "/var/lib/paperless" ];
  };
}
