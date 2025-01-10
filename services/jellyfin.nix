/*
* The free software media system.
* https://github.com/jellyfin/jellyfin
*/

{ config, domain, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Internal domain
  services.nginx.virtualHosts."jellyfin.${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString 8096}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [
    config.services.jellyfin.dataDir
  ];
}
