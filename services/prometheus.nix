/*
  * Monitoring system and time series database.
  * https://github.com/prometheus/prometheus
*/

{ config, lib, hosts, host, ... }:
let
  state = "/persist/data/prometheus";
in
{
  config = lib.mkIf (builtins.elem "prometheus" host.services) {
    modules.services.prometheus = {
      mounts = {
        "/var/lib/${config.services.prometheus.stateDir}" = {
          hostPath = state;
          isReadOnly = false;
        };
      };

      config.services.prometheus = {
        enable = true;
        port = config.modules.services.prometheus.port;
        scrapeConfigs = [
          {
            job_name = "node";
            scheme = "https";
            static_configs = [
              { targets = builtins.map (host: "${host}.pweth.com") (builtins.attrNames hosts); }
            ];
          }
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
