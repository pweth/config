/*
* Common configuration across all hosts that use impermanence.
*/

{ config, lib, host, user, ... }:

{
  config = lib.mkIf (builtins.hasAttr "persistent" host) {
    # Add persistent key path to agenix
    age.identityPaths = [ "${host.persistent}/etc/ssh/ssh_host_ed25519_key" ];

    # Essential /etc files
    environment.etc = {
      machine-id.source = "${host.persistent}/etc/machine-id";
      "ssh/ssh_host_ed25519_key".source = "${host.persistent}/etc/ssh/ssh_host_ed25519_key";
    };
    
    # Use hidden bind mounts and persist required directories
    environment.persistence."${host.persistent}" = {
      hideMounts = true;
      directories = lib.mkMerge [
        [
          "/etc/nixos/config"
          "/var/lib/systemd/coredump"
          "/var/log/journal"
        ]
        (lib.mkIf config.networking.networkmanager.enable [
          "/etc/NetworkManager/system-connections"
        ])
        (lib.mkIf config.hardware.bluetooth.enable [
          "/var/lib/bluetooth"
        ])
      ];
      users."${user}".files = [ ".bash_history" ];
    };
  };
}
