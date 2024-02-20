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
  environment.persistence."${host.persistent}".directories = 
    if (builtins.hasAttr "persistent" host)
    then [ "/var/lib/docker" ]
    else [];
}
