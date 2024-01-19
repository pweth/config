/*
* Default user configuration for `pweth`.
*/

{ config, host, ... }:

{
  # User account
  users.users.pweth = {
    description = "Peter";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2LcPpOlnOwQ67Xp6uJnuOmDj0W06Bzyr73l6xkZgtg"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKHts3hkSwRHwuxQYZDldRZ6Z+SDd3zXOxxX5fOmszD1AAAABHNzaDo="
    ];
  };

  # Message of the day
  users.motd = "Connected to ${host.name}.";

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;

  # Enable sudo logins if using an authorized key
  security.pam.enableSSHAgentAuth = true;
  security.pam.services.sudo.sshAgentAuth = true;
  security.pam.services.su.requireWheel = true;
}
