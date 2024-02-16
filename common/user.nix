/*
* Default user configuration for `pweth`.
*/

{ config, host, keys, ... }:

{
  # User account
  users = {
    mutableUsers = false;
    users.pweth = {
      createHome = true;
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
      uid = 1000;
    };
  };

  # Message of the day
  users.motd = "Connected to ${host.name}.";

  # Password hash
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "/persist/etc/ssh/ssh_host_ed25519_key"
  ];
  age.secrets.password-hash.file = ../secrets/password-hash.age;
  users.users.pweth.hashedPasswordFile = config.age.secrets.password-hash.path;
}
