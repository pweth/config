/*
  * A self-hosted lightweight software forge.
  * https://forgejo.org/
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/forgejo";
in
{
  config = lib.mkIf (host.services.forgejo or null != null) {
    modules.services.forgejo = {
      subdomain = host.services.forgejo;
      address = "192.168.1.4";

      mounts = {
        "${config.services.forgejo.stateDir}" = {
          hostPath = state;
          isReadOnly = false;
        };
      };

      config.services.forgejo = {
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
            DOMAIN = "${host.services.forgejo}.pweth.com";
            HTTP_PORT = config.modules.services.forgejo.port;
            LANDING_PAGE = "login";
            ROOT_URL = "https://${host.services.forgejo}.pweth.com/";
          };
          ui = {
            DEFAULT_THEME = "forgejo-dark";
            SHOW_USER_EMAIL = false;
          };
        };
      };
    };

    services.nginx.virtualHosts."${host.services.forgejo}.pweth.com".extraConfig = ''
      client_max_body_size 512M;
    '';

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
