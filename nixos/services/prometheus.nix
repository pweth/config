{ config, ... }:

{
  # Service
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "node";
        scheme = "http";
        static_configs = [{
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
            ];
        }];
      }
    ];
  };

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/${config.services.prometheus.stateDir}"
  ];

  # Virtual host
  services.nginx.virtualHosts."prometheus.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/".proxyPass = "http://localhost:${toString config.services.prometheus.port}";
  };
}
