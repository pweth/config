/*
  * Monitoring system and time series database.
  * https://github.com/prometheus/prometheus
*/

{ config, lib, hosts, host, ... }:
let
  domain = host.services.prometheus or null;
  port = 58635;
in
{
  config = lib.mkIf (domain != null) {
    services.prometheus = {
      enable = true;
      port = port;
      scrapeConfigs = [
        {
          job_name = "node";
          scheme = "https";
          static_configs = [
            { targets = builtins.map (host: "${host}.ipn.pw") (builtins.attrNames hosts); }
          ];
        }
        {
          job_name = "blocky";
          scheme = "https";
          static_configs = [
            { targets = [ "${host.services.blocky}.pweth.com" ]; }
          ];
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
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };
}
