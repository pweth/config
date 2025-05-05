/*
  * Query, visualize, alerting observability platform.
  * https://github.com/grafana/grafana
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/grafana";
in
{
  config = lib.mkIf (builtins.elem "grafana" host.services) {
    age.secrets.grafana = {
      file = ../secrets/grafana.age;
      mode = "004";
    };

    modules.services.grafana = {
      mounts = {
        "${config.age.secrets.grafana.path}".isReadOnly = true;
        "${config.services.grafana.dataDir}" = {
          hostPath = state;
          isReadOnly = false;
        };
      };

      config.services.grafana = {
        enable = true;
        settings = {
          analytics = {
            check_for_plugin_updates = false;
            check_for_updates = false;
            feedback_links_enabled = false;
            reporting_enabled = false;
          };
          "auth.anonymous" = {
            enabled = true;
            org_name = "Main Org.";
            org_role = "Viewer";
          };
          security = {
            admin_user = "pweth";
            admin_password = "$__file{${config.age.secrets.grafana.path}}";
            disable_gravatar = true;
          };
          server = {
            domain = "${config.modules.services.grafana.subdomain}.pweth.com";
            http_port = config.modules.services.grafana.port;
          };
          users = {
            default_language = "en-GB";
            default_theme = "dark";
            home_page = "/d/aeh8ykwdw3bb4d/home-page";
          };
        };
      };

      config.services.nginx.virtualHosts."${config.modules.services.grafana.subdomain}.pweth.com".extraConfig = ''
        proxy_pass_header Authorization;
      '';
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
