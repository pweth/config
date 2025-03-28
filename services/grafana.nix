/*
  * Query, visualize, alerting observability platform.
  * https://github.com/grafana/grafana
*/

{ config, domain, ... }:
let
  port = 59663;
in
{
  age.secrets.grafana = {
    file = ../secrets/grafana.age;
    owner = "grafana";
  };

  # Service configuration
  services.grafana = {
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
        domain = "grafana.${domain}";
        http_port = port;
      };
      users = {
        default_language = "en-GB";
        default_theme = "dark";
        home_page = "/d/aeh8ykwdw3bb4d/home-page";
      };
    };
  };

  # Internal domain
  services.nginx.virtualHosts."grafana.${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
    };
    sslCertificate = ../static/certs/service.crt;
    sslCertificateKey = config.age.secrets.service.path;
  };

  # Persist service data
  environment.persistence."/persist".directories = [ config.services.grafana.dataDir ];
}
