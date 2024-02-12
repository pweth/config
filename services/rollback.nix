/*
* Rollback btrfs root subvolume to a blank slate.
*/

{ config, pkgs, hostName, ... }: 

{
  boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/mapper/enc /mnt
    btrfs subvolume list -o /mnt/root |
      cut -f 9 -d ' ' |
      while read subvolume; do
        echo "Deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
      echo "Deleting /root subvolume..." &&
      btrfs subvolume delete /mnt/root
    echo "Restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/root-blank /mnt/root
    umount /mnt
  '';

  # Files to persist
  environment.etc = {
    adjtime.source = "/persist/etc/adjtime";
    machine-id.source = "/persist/etc/machine-id";
    "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
  };
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/blueman"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/NetworkManager"
      "/var/lib/systemd/coredump"
      "/var/lib/tailscale"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "750"; }
    ];
  };
}
