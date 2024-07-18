/*
* Object-storage backup configuration.
* To initiate the service: `touch ~/.config/backup/.enable`
*/

{ config, lib, pkgs, host, user, ... }:

{
  # Mount environment file
  age.secrets.restic.file = ../secrets + "/restic-${host.name}.age";

  # Systemd backup service (10 minutes after boot, then every hour)
  systemd = {
    services.backup = {
      script = ''
        LOG_FILE=/home/${user}/.config/backup/info.log
        if [ ! -f "/home/${user}/.config/backup/.enable" ]; then
          echo "[$(date)] Backups not enabled, skipping." >>$LOG_FILE
          exit 0
        fi

        # Determine if a snapshot for today exists
        TODAY=$(date +"%Y-%m-%d")
        LAST_SNAPSHOT=$(${pkgs.restic}/bin/restic snapshots --json | ${pkgs.jq}/bin/jq ".[-1].time")
        LAST_DATE=$(echo $LAST_SNAPSHOT | cut -c "2-11")

        # Backup if appropriate
        if [ $LAST_SNAPSHOT == "null" ] || [ $TODAY > $LAST_DATE ] && [ $TODAY != $LAST_DATE ]; then
          echo "[$(date)] Creating snapshot for $TODAY." >>$LOG_FILE
          ${pkgs.restic}/bin/restic backup /persist >>$LOG_FILE
          echo "[$(date)] Backup complete." >>$LOG_FILE
        else
          echo "[$(date)] Snapshot already exists for $TODAY, skipping." >>$LOG_FILE
        fi
      '';
      serviceConfig = {
        EnvironmentFile = config.age.secrets.restic.path;
        Type = "oneshot";
        User = "root";
      };
    };
    timers.backup = {
      timerConfig = {
        OnBootSec = "10m";
        OnUnitActiveSec = "1h";
        Unit = "backup.service";
      };
      after = [ "run-agenix.d.mount" ];
      wantedBy = [ "timers.target" ];
      wants = [ "run-agenix.d.mount" ];
    };
  };

  # Persist service configuration
  environment.persistence = lib.mkIf host.impermanent {
    "/persist".users."${user}".directories = [ ".config/backup" ];
  };
}
