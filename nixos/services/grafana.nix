{ config, ... }:

{
  # Password
  age.secrets.grafana = {
    file = ../agenix/grafana.age;
    mode = "004";
  };

  # Service
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
        admin_user = "pweth";
        admin_password = "$__file{${config.age.secrets.grafana.path}}";
        disable_gravatar = true;
      };
      server.domain = "grafana.intranet.london";
      users = {
        default_language = "en-GB";
        default_theme = "dark";
      };
    };
  };

  # State
  environment.persistence."/persist".directories = [
    config.services.grafana.dataDir
  ];

  # Virtual host
  services.nginx.virtualHosts."grafana.intranet.london" = {
    forceSSL = true;
    useACMEHost = "intranet";
    locations."/".proxyPass = "http://localhost:${toString config.services.grafana.settings.server.http_port}";
    extraConfig = ''
      proxy_pass_header Authorization;
    '';
  };
}
