/*
* Prometheus Node Exporter configuration.
* https://github.com/prometheus/node_exporter
*/

{ config, ... }:

{
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 12345;
  };
}
