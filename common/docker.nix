/*
* Docker configuration.
*/

{ config, lib, host, ... }:

{
  # Enable Docker
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };

  # Persist application data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ "/var/lib/docker" ];
  };
}
