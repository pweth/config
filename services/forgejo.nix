/*
  * A self-hosted lightweight software forge.
  * https://forgejo.org/
*/

{ config, lib, host, ... }:
let
  domain = host.services.forgejo or null;
  port = 23784;
in
{
  config = lib.mkIf (domain != null) {
    # Service
    services.forgejo = {
      enable = true;
      database.type = "sqlite3";
      lfs.enable = true;
      settings = {
        DEFAULT.APP_NAME = "Forgejo";
        admin = {
          DEFAULT_EMAIL_NOTIFICATIONS = "disabled";
          USER_DISABLED_FEATURES = "deletion";
        };
        other = {
          ENABLE_FEED = false;
          ENABLE_SITEMAP = false;
          SHOW_FOOTER_POWERED_BY = false;
          SHOW_FOOTER_TEMPLATE_LOAD_TIME = false;
          SHOW_FOOTER_VERSION = false;
        };
        repository = {
          DEFAULT_PUSH_CREATE_PRIVATE = false;
          DISABLE_STARS = true;
          DISABLED_REPO_UNITS = "repo.projects,repo.wiki";
        };
        server = {
          DOMAIN = domain;
          HTTP_PORT = port;
          LANDING_PAGE = "login";
          ROOT_URL = "https://${domain}/";
        };
        ui = {
          DEFAULT_THEME = "forgejo-dark";
          SHOW_USER_EMAIL = false;
        };
      };
    };

    # Internal domain
    services.nginx.virtualHosts."${domain}" = {
      extraConfig = ''
        client_max_body_size 512M;
      '';
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:${builtins.toString port}";
        proxyWebsockets = true;
      };
      sslCertificate = ../static/pweth.crt;
      sslCertificateKey = config.age.secrets.certificate.path;
    };
  };
}
