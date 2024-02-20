/*
* Common configuration across all hosts that use impermanence.
*/

{ config, lib, host, ... }:

{
  config = lib.mkIf (builtins.hasAttr "persistent" host) {
    # Add persistent key path to agenix
    age.identityPaths = [ "${host.persistent}/etc/ssh/ssh_host_ed25519_key" ];

    # Essential /etc files
    environment.etc = {
      machine-id.source = "${host.persistent}/etc/machine-id";
      "ssh/ssh_host_ed25519_key".source = "${host.persistent}/etc/ssh/ssh_host_ed25519_key";
    };
    
    # Persist system logs and use hidden bind mounts
    environment.persistence."${host.persistent}" = {
      directories = [
        "/etc/nixos/config"
        "/var/lib/systemd/coredump"
        "/var/log/journal"
      ];
      hideMounts = true;
    };
  };  
}
