{ config, inputs, ... }:

{
  imports = with inputs; [
    agenix.nixosModules.default
  ];

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ./agenix/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;

  # Set public key for host
  environment.etc."ssh/ssh_host_ed25519_key.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALl6nmhTzqES2qmootEZ6x8DuomSvJCzYTormEevq4y";

  # Enable passwordless sudo for remote deployments
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
  };
}
