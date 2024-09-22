/*
* Default user configuration.
*/

{ config, host, keys, user, ... }:

{
  # User account
  users.users."${user}" = {
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
    openssh.authorizedKeys.keys = [
      keys.igneous.ssh
      keys.metamorphic.ssh
      keys.sedimentary.ssh
    ];
    uid = 1000;
  };

  # Add ~/.local/bin to path
  environment.localBinInPath = true;

  # Message of the day
  users.motd = "Connected to ${host.species}.";

  # Immutable users
  users.mutableUsers = false;

  # Static UIDs and GIDs
  users.users = {
    nm-iodine.uid = 999;
    node-exporter.uid = 998;
    nscd.uid = 997;
    rtkit.uid = 996;
    systemd-oom.uid = 995;
  };
  users.groups = {
    msr.gid = 999;
    node-exporter.gid = 998;
    nscd.gid = 997;
    polkituser.gid = 996;
    rtkit.gid = 995;
    systemd-coredump.gid = 994;
    systemd-oom.gid = 993;
  };
}
