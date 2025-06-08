/*
  * Minecraft server.
*/

{ config, lib, hosts, host, ... }:
let
  state = "/persist/data/minecraft";
in
{
  config = lib.mkIf (builtins.elem "minecraft" host.services) {
    modules.services.minecraft = {
      mounts = {
        "${config.services.minecraft-server.dataDir}" = {
          hostPath = state;
          isReadOnly = false;
        };
      };

      config.services.minecraft-server = {
        enable = true;
        eula = true;
      };
    };

    systemd.tmpfiles.rules = [
      "d ${state} 0770 999 999 -"
    ];
  };
}
