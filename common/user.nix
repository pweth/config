/*
* Default user configuration.
*/

{ config, host, user, ... }:

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
      openssh.authorizedKeys.keyFiles = [
        (builtins.readFile ../keys/ssh/igneous.pub)
        (builtins.readFile ../keys/ssh/metamorphic.pub)
        (builtins.readFile ../keys/ssh/sedimentary.pub)
      ];
      uid = 1000;
    };
  };

  # Message of the day
  users.motd = "Connected to ${host.species}.";
}
