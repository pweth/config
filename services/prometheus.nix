/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, hosts, host, ... }:

{
  services.prometheus = {
    enable = true;
    port = host.entrypoints.prometheus.port;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = builtins.map (
            name: "${name}.home.arpa:${toString config.services.prometheus.exporters.node.port}"
          ) (builtins.attrNames hosts);
        }];
      }
    ];
  };
}
