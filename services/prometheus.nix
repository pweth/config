/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, lib, domain, host, hosts, ... }:
let
  subdomain = "prometheus.${domain}";
  port = 58635;
  blackbox_port = 58636;
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
            name: "${name}.ipn.${domain}"
          ) (builtins.attrNames hosts);
        }];
      }
    ];

    # Enable blackbox exporter for probing endpoints
    exporters.blackbox = {
      enable = true;
      port = blackbox_port;
    };
  };

  # Internal domain
  services.nginx.virtualHosts."${subdomain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/pweth.crt;
    sslCertificateKey = config.age.secrets.certificate.path;
  };

  # Persist service data
  environment.persistence = lib.mkIf host.impermanent {
    "/persist".directories = [ "/var/lib/${config.services.prometheus.stateDir}" ];
  };
}
