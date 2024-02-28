/*
* Query, visualize, alerting observability platform.
* https://github.com/grafana/grafana
*/

{ config, host, ... }:
let
  domain = "grafana.home.arpa";
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
      security = {
        admin_user = "admin";
        admin_password = "$__file{${config.age.secrets.grafana.path}}";
        disable_gravatar = true;
      };
      server = {
        domain = domain;
        http_port = port;
      };
      user = {
        default_language = "en-GB";
        default_theme = "dark";
      };
    };
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
    "${host.persistent}".directories = [ config.services.grafana.dataDir ];
  };
}
