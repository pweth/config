/*
* HTTP and reverse proxy server.
* https://nginx.org/
*/

{ config, ... }:

{
  # Reverse proxy
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;
  };

  # Mount TLS certificate key
  age.secrets.certificate = {
    file = ../secrets/certificate.age;
    owner = "nginx";
  };
}
