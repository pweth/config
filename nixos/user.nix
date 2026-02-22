{ host, keys, ... }:

{
  # User account
  users.users.pweth = {
    createHome = true;
    description = "Peter";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = with keys; [
      igneous.ssh
      metamorphic.ssh
      sedimentary.ssh
    ];
    uid = 1000;
  };

  # Message of the day
  users.motd = "Connected to ${host.species}.";

  # Immutable users
  users.mutableUsers = false;
}
