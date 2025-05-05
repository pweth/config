/*
  * Self-hosted Anki sync server.
  * https://docs.ankiweb.net/sync-server.html
*/

{ config, lib, host, ... }:

{
  config = lib.mkIf (builtins.elem "anki-sync" host.services) {
    # Sync server password
    age.secrets.anki.file = ../secrets/anki.age;

    modules.services.anki-sync = {
      address = "192.168.1.2";

      mounts = {
        "${config.age.secrets.anki.path}".hostPath = config.age.secrets.anki.path;
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
  };
}
