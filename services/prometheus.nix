/*
* Monitoring system and time series database. 
* https://github.com/prometheus/prometheus
*/

{ config, lib, hosts, ... }:
let
  domain = "prometheus.home.arpa";
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
            name: "${name}.ipn.home.arpa"
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
    sslCertificate = config.age.secrets.internal-cert.path;
    sslCertificateKey = config.age.secrets.internal-key.path;
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/${config.services.prometheus.stateDir}" ];
  };
}
