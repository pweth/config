/*
* SSH configuration.
*/

{ config, hosts, ... }:

{
  # OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      ChallengeResponseAuthentication = false;
      GSSAPIAuthentication = false;
      KerberosAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
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
      "github.com".publicKey = builtins.readFile ../static/keys/github.pub;
      "git.sr.ht".publicKey = builtins.readFile ../static/keys/sourcehut.pub;
    };
  };

  # Enable passwordless sudo for remote deployments
  security.sudo.wheelNeedsPassword = false;

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