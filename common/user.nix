/*
* Default user configuration for `pweth`.
*/

{ config, host, keys, ... }:

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
    openssh.authorizedKeys.keyFiles = [ keys.outPath ];
  };

  # Message of the day
  users.motd = "Connected to ${host.name}.";

  # Password hash
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
