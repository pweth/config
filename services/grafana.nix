/*
* Query, visualize, alerting observability platform.
* https://github.com/grafana/grafana
*/

{ config, lib, domain, host, ... }:
let
  subdomain = "grafana.${domain}";
  port = 59663;
in
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
        domain = subdomain;
        http_port = port;
      };
      user = {
        default_language = "en-GB";
        default_theme = "dark";
      };
    };
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
  environment.persistence = lib.mkIf host.impermanent {
    "/persist".directories = [ config.services.grafana.dataDir ];
  };
}
