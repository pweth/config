/*
* Query, visualize, alerting observability platform.
* https://github.com/grafana/grafana
*/

{ config, host, ... }:

{
  age.secrets.grafana = {
    file = ../secrets/grafana.age;
    owner = "grafana";
  };

  services.grafana = {
    enable = true;
    settings = {
      analytics = {
        check_for_plugin_updates = false;
        check_for_updates = false;
        feedback_links_enabled = false;
        reporting_enabled = false;
      };
      security = {
        admin_user = "admin";
        admin_password = "$__file{${config.age.secrets.grafana.path}}";
        disable_gravatar = true;
      };
      server = {
        domain = host.entrypoints.grafana.domain;
        http_port = host.entrypoints.grafana.port;
      };
      user = {
        default_language = "en-GB";
        default_theme = "dark";
      };
    };
  };
}
