/*
* Tailscale configuration.
*/

{ config, lib, host, user, ... }:

{
  # Mount authentication key
  age.secrets.tailscale.file = ../secrets/tailscale.age;

  # Configure service
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
    extraUpFlags = [
      "--accept-dns=true"
      "--operator=${user}"
    ];
  };

  # Persist application data
  environment.persistence = lib.mkIf host.impermanent {
    "/persist".directories = [ "/var/lib/tailscale" ];
  };
}
