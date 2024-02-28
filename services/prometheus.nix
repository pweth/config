/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, host, hosts, ... }:
let
  domain = "prometheus.pweth.com";
  port = 58635;
in
{
  services.prometheus = {
    enable = true;
    port = port;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = builtins.map (
            name: "${name}.ipn.home.arpa:12345"
          ) (builtins.attrNames hosts);
        }];
      }
    ];
  };

  # Cloudflare tunnel
  services.cloudflared.tunnels."${host.tunnel}".ingress = {
    "${domain}" = "http://localhost:${builtins.toString port}";
  };
}
