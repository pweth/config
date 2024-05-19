/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, lib, host, hosts, ... }:
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
        scheme = "https";
        static_configs = [{
          targets = builtins.map (
            name: "${name}.ipn.pw"
          ) (builtins.attrNames hosts);
        }];
      }
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    useACMEHost = "internal";
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/${config.services.prometheus.stateDir}" ];
  };
}
