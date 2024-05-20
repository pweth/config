/*
* SSH configuration.
*/

{ config, domain, host, hosts, user, ... }:

{
  # Set public key for host
  environment.etc."ssh/ssh_host_ed25519_key.pub".source = ../keys/ssh + "/${host.name}.pub";
  
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
    knownHosts = (builtins.listToAttrs (builtins.concatMap (
        name: [
          { name = "${name}.ipn.${domain}"; value.publicKey = builtins.readFile (../keys/ssh + "/${name}.pub"); }
          { name = name; value.publicKey = builtins.readFile (../keys/ssh + "/${name}.pub"); }
        ]
    ) (builtins.attrNames hosts))) // {
      "github.com".publicKey = builtins.readFile ../keys/ssh/github.pub;
      "git.sr.ht".publicKey = builtins.readFile ../keys/ssh/sourcehut.pub;
      "git.${domain}".publicKey = builtins.readFile ../keys/ssh/humboldt.pub;
    };
  };

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users."${user}".hashedPasswordFile = config.age.secrets.password-hash.path;
}
