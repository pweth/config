# * Security configuration.

{
  config,
  host,
  keys,
  ...
}:

{
  # Mount age secrets
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets = {
    certificate = {
      file = ../secrets/pweth.crt.age;
      owner = "nginx";
    };
    password-hash.file = ../secrets/password-hash.age;
  };

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
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
