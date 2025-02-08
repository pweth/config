# * Default user configuration.

{
  config,
  host,
  keys,
  user,
  ...
}:

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
}
