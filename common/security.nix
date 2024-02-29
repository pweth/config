/*
* SSH configuration.
*/

{ config, host, hosts, user, ... }:

{
  # Set public key for host
  environment.etc."ssh/ssh_host_ed25519_key.pub".text = host.ed25519;

  # Add internal CA
  security.pki.certificateFiles = [ ../static/keys/internal-ca.crt ];
  
  # Enable passwordless sudo for remote deployments and disable lecture
  security.sudo = {
    extraConfig = ''
      Defaults lecture = never
    '';
    wheelNeedsPassword = false;
  };

  # fail2ban with default jails
  services.fail2ban.enable = true;

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

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users."${user}".hashedPasswordFile = config.age.secrets.password-hash.path;
}
