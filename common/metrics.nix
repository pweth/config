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

  # Mount internal certificate
  age.secrets.home-arpa-key = {
    file = ../secrets/home-arpa-key.age;
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
    virtualHosts = {
      "${host.name}.home.arpa" = {
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
          proxyWebsockets = true;
        };
        sslCertificate = ../keys/certificates/home-arpa.crt;
        sslCertificateKey = config.age.secrets.home-arpa-key.path;
      };
      "default" = {
        default = true;
        locations."/".return = "444";
        rejectSSL = true;
      };
    };
  };
}
