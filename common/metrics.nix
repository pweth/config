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

  # IPN hostname for metrics
  services.nginx.virtualHosts."${host.name}.ipn.pw" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString config.services.prometheus.exporters.node.port}";
      proxyWebsockets = true;
    };
    useACMEHost = "internal";
  };
}
