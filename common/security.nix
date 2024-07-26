/*
* SSH configuration.
*/

{ config, domain, host, hosts, user, ... }:

{
  # Set public key for host
  environment.etc."ssh/ssh_host_ed25519_key.pub".text = host.key;

  # Enable passwordless sudo for remote deployments
  security.sudo = {
    extraConfig = ''
      Defaults lecture = never
    '';
    wheelNeedsPassword = false;
  };

  # SSH agent
  programs.ssh = {
    knownHosts = (builtins.listToAttrs (builtins.concatLists (builtins.attrValues (builtins.mapAttrs (
        name: host: [
          { name = "${name}.ipn.${domain}"; value.publicKey = host.key; }
          { name = name; value.publicKey = host.key; }
        ]
    ) hosts)))) // {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      "git.sr.ht".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
      "git.${domain}".publicKey = hosts.humboldt.key;
    };
    startAgent = true;
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
  };

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users."${user}".hashedPasswordFile = config.age.secrets.password-hash.path;
}
