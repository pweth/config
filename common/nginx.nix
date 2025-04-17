/*
  * HTTP and reverse proxy server.
  * https://nginx.org/
*/

{
  config,
  host,
  ...
}:

{
  # Mount TLS certificate key
  age.secrets.certificate = {
    file = ../secrets/pweth.crt.age;
    owner = "nginx";
  };

  services.nginx = {
    enable = true;

    # Use recommended settings
    clientMaxBodySize = "0";
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;

    # Metrics exporter
    virtualHosts."${host.name}.pweth.com" = {
      forceSSL = true;
      locations."/".proxyPass =
        "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };
}
