# * SSH configuration.

{
  config,
  pkgs,
  host,
  hosts,
  keys,
  ...
}:

{
  # Set public key for host
  environment.etc."ssh/ssh_host_ed25519_key.pub".text = host.ssh-key;

  # Enable passwordless sudo for remote deployments
  security.sudo = {
    extraConfig = ''
      Defaults lecture = never
    '';
    wheelNeedsPassword = false;
  };

  # SSH agent
  programs.ssh = {
    enableAskPassword = false;
    startAgent = true;

    # Add private keys to ssh-agent
    extraConfig = builtins.concatStringsSep "\n" (
      builtins.map (key: "IdentityFile /home/pweth/.ssh/${key}") (builtins.attrNames keys)
    );

    # Pre-populate known hosts
    knownHosts =
      (builtins.listToAttrs (
        builtins.concatLists (
          builtins.attrValues (
            builtins.mapAttrs (name: host: [
              {
                name = "${name}.pweth.com";
                value.publicKey = host.ssh-key;
              }
              {
                name = name;
                value.publicKey = host.ssh-key;
              }
            ]) hosts
          )
        )
      ))
      // {
        "github.com".publicKey =
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
        "git.pweth.com".publicKey = hosts.humboldt.ssh-key;
      };
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

  # Smart card daemon for Yubikeys
  services.pcscd.enable = true;

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
