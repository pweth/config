/*
* SSH configuration.
*/

{ config, hosts, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      ChallengeResponseAuthentication = false;
      GSSAPIAuthentication = false;
      KerberosAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = false;
    };

    # Add host and version control key fingerprints
    knownHosts = (builtins.listToAttrs (builtins.attrValues (
      builtins.mapAttrs (
        name: host: {
          name = "${name}.home.arpa";
          value.publicKey = host.ed25519;
        }
      ) hosts
    ))) // {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      "git.sr.ht".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
    };
  };

  # Enable fail2ban with default jails
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
    ];
  };
}
