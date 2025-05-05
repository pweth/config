/*
  * Self-hosted Anki sync server.
  * https://docs.ankiweb.net/sync-server.html
*/

{ config, lib, host, ... }:

{
  config = lib.mkIf (builtins.elem "anki-sync" host.services) {
    age.secrets.anki.file = ../secrets/anki.age;

    modules.services.anki-sync = {
      mounts = {
        "${config.age.secrets.anki.path}".isReadOnly = true;
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
