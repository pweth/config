/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, domain, hosts, ... }:
let
  subdomain = "prometheus.${domain}";
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
            name: "${name}.ipn.${domain}"
          ) (builtins.attrNames hosts);
        }];
      }
    ];
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
  environment.persistence."/persist".directories = [ "/var/lib/${config.services.prometheus.stateDir}" ];
}
