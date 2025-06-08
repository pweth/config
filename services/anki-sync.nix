/*
  * Self-hosted Anki sync server.
  * https://docs.ankiweb.net/sync-server.html
*/

{ config, lib, host, ... }:
let
  state = "/persist/data/anki";
in
{
  config = lib.mkIf (builtins.elem "anki-sync" host.services) {
    age.secrets.anki.file = ../secrets/anki.age;

    modules.services.anki-sync = {
      mounts = {
        "${config.age.secrets.anki.path}".isReadOnly = true;
        "/var/lib/private/anki-sync-server/pweth" = {
          hostPath = state;
          isReadOnly = false;
        };
      };

      config.services.anki-sync-server = {
        enable = true;
        port = config.modules.services.anki-sync.port;
        users = [
          {
            username = "pweth";
            passwordFile = config.age.secrets.anki.path;
          }
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
