{ config, ... }:

{
  # Service
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "node";
        scheme = "https";
        static_configs = [
          {
            targets = [
              "intranet.london"
            ];
          }
        ];
      }
    ];
  };

  # State
  environment.persistence."/persist".directories = [
    "/var/lib/${config.services.prometheus.stateDir}"
  ];

  # Virtual hosts
  services.nginx.virtualHosts = {
    "intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass =
        "http://localhost:${toString config.services.prometheus.exporters.node.port}";
    };
    "prometheus.intranet.london" = {
      forceSSL = true;
      useACMEHost = "intranet";
      locations."/".proxyPass = "http://localhost:${toString config.services.prometheus.port}";
    };
  };
}
