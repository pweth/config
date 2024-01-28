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
      "docker"
      "networkmanager"
      "podman"
      "wheel"
    ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKHts3hkSwRHwuxQYZDldRZ6Z+SDd3zXOxxX5fOmszD1AAAABHNzaDo="
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKo1ORI0Ijxm+1VR5Ik5nHKisDIlQcwkZnCfr2xMJHVQAAAABHNzaDo="
    ];
  };

  # Message of the day
  users.motd = "Connected to ${host.name}.";

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
