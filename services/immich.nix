/*
  * High performance self-hosted photo and video management solution.
  * https://github.com/immich-app/immich
*/

{ config, domain, ... }:

{
  # Service configuration
  services.immich.enable = true;

  # Internal domain
  services.nginx.virtualHosts."photos.${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString config.services.immich.port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [
    config.services.immich.mediaLocation
    config.services.postgresql.dataDir
  ];
}
