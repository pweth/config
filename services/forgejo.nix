/*
  * A self-hosted lightweight software forge.
  * https://forgejo.org/
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/forgejo";
in
{
  config = lib.mkIf (builtins.elem "forgejo" host.services) {
    modules.services.forgejo = {
      subdomain = "git";

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
            DOMAIN = "${config.modules.services.forgejo.subdomain}.pweth.com";
            HTTP_PORT = config.modules.services.forgejo.port;
            LANDING_PAGE = "login";
            ROOT_URL = "https://${config.modules.services.forgejo.subdomain}.pweth.com/";
          };
          ui = {
            DEFAULT_THEME = "forgejo-dark";
            SHOW_USER_EMAIL = false;
          };
        };
      };

      config.services.nginx.virtualHosts."${config.modules.services.forgejo.subdomain}.pweth.com".extraConfig = ''
        client_max_body_size 512M;
      '';
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
