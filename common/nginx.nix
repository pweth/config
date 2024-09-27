/*
* HTTP and reverse proxy server.
* https://nginx.org/
*/

{ config, domain, host, ... }:

{
  # Mount TLS certificate key
  age.secrets.certificate = {
    file = ../secrets/certificate.age;
    owner = "nginx";
  };

  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;

    # IPN hostname for metrics
    virtualHosts."${host.name}.ipn.${domain}" = {
      forceSSL = true;
      locations."/".proxyPass = "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };

    # Return 444 for unrecognised hostnames
    virtualHosts."_" = {
      forceSSL = true;
      extraConfig = "return 444;";
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };
}
