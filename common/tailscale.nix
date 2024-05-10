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
    extraUpFlags = [ "--accept-dns=false" ];
  };

  # Persist application data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/tailscale" ];
  };
}
