/*
* Prometheus Node Exporter configuration.
* https://github.com/prometheus/node_exporter
*/

{ config, host, ... }:

{
  # Node exporter
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 12345;
  };

  # Mount internal certificates
  age.secrets.internal-cert = {
    file = ../secrets/internal-cert.age;
    owner = "nginx";
  };
  age.secrets.internal-key = {
    file = ../secrets/internal-key.age;
    owner = "nginx";
  };

  # Reverse proxy
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # IPN hostname for metrics
    virtualHosts."${host.name}.ipn.home.arpa" = {
      default = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
        proxyWebsockets = true;
      };
      sslCertificate = config.age.secrets.internal-cert.path;
      sslCertificateKey = config.age.secrets.internal-key.path;
    };
  };
}
