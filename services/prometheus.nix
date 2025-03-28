/*
  * Monitoring system and time series database.
  * https://github.com/prometheus/prometheus
*/

{
  config,
  domain,
  hosts,
  ...
}:
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
        static_configs = [
          { targets = builtins.map (host: "${host}.ipn.pw") (builtins.attrNames hosts); }
        ];
      }
      {
        job_name = "blocky";
        scheme = "https";
        static_configs = [
          { targets = [ "dns.pweth.com" ]; }
        ];
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
    sslCertificate = ../static/certs/service.crt;
    sslCertificateKey = config.age.secrets.service.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [
    "/var/lib/${config.services.prometheus.stateDir}"
  ];
}
