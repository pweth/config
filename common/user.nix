/*
* Default user configuration.
*/

{ config, host, user, keys, ... }:

{
  # User account
  users = {
    mutableUsers = false;
    users."${user}" = {
      createHome = true;
      description = user;
      extraGroups = [
        "dialout"
        "docker"
        "networkmanager"
        "podman"
        "root"
        "wheel"
      ];
      isNormalUser = true;
      openssh.authorizedKeys.keyFiles = [ keys.outPath ];
      uid = 1000;
    };
  };

  # Message of the day
  users.motd = "Connected to ${host.species}.";
}
