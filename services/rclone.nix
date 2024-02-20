/*
* rclone object-storage backup configuration.
* To initiate the service: `touch ~/.config/rclone/.enable`
*/

{ config, pkgs, ... }:
let
  providers = [ "backblaze" "cloudflare" ];
  target = "/home/pweth/Documents/";
in
{
  # Mount configuration
  age.secrets.rclone.file = ../secrets/rclone.age;

  # Systemd sync service
  systemd.services.rclone-sync = {
    script = (builtins.concatStringsSep "\n" ([''
      if [ ! -f "/home/pweth/.config/rclone/.enable" ]; then
        exit 0
      fi
    ''] ++ (builtins.map (provider: ''
      ${pkgs.rclone}/bin/rclone sync ${target} ${provider}-crypt: \
        --config "${config.age.secrets.rclone.path}" \
        --exclude ".*/" \
        --log-file /home/pweth/.config/rclone/sync.log \
        --log-level INFO
    '') providers)));
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  # Systemd sync timer (10 minutes after boot, then every hour)
  systemd.timers.rclone-sync = {
    timerConfig = {
      OnBootSec = "10m";
      OnUnitActiveSec = "1h";
      Unit = "rclone-sync.service";
    };
    after = [ "run-agenix.d.mount" ];
    wantedBy = [ "timers.target" ];
    wants = [ "run-agenix.d.mount" ];
  };

  # Persist service configuration
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".users.pweth.directories = [ ".config/rclone" ];
  };
}
