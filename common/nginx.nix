/*
  * HTTP and reverse proxy server.
  * https://nginx.org/
*/

{
  config,
  domain,
  host,
  ...
}:

{
  # Mount TLS certificate key
  age.secrets.ipn = {
    file = ../secrets/ipn.age;
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

    # Hostname for metrics
    virtualHosts."${host.name}.ipn.pw" = {
      forceSSL = true;
      locations."/".proxyPass =
        "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
      sslCertificate = ../static/certs/ipn.crt;
      sslCertificateKey = config.age.secrets.ipn.path;
    };

    # Return 444 for unrecognised hostnames
    virtualHosts."_" = {
      forceSSL = true;
      extraConfig = "return 444;";
      sslCertificate = ../static/certs/ipn.crt;
      sslCertificateKey = config.age.secrets.ipn.path;
    };
  };
}
