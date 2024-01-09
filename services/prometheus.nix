/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, ... }:

{
  services.prometheus = {
    enable = true;
    port = 58635;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };
}
