/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, hosts, ... }:

{
  services.prometheus = {
    enable = true;
    port = 58635;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = builtins.map (
            name: "${name}.home.arpa:12345"
          ) (builtins.attrNames hosts);
        }];
      }
    ];
  };
}
