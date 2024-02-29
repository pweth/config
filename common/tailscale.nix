/*
* Tailscale configuration.
*/

{ config, lib, host, hosts, ... }:

{
  # Mount authentication key
  age.secrets.tailscale.file = ../secrets/tailscale.age;

  # Configure service
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
  };

  # host.home.arpa DNS entries
  networking.hosts = builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs (
    name: value: {
      name = value.address;
      value = [ "${name}.home.arpa" ];
    }
  ) hosts));

  # Persist application data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/tailscale" ];
  };
}
