/*
* An easy-to-use self-hosted monitoring tool.
* https://github.com/louislam/uptime-kuma
*/

{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.status = {
    autoStart = true;
    image = "elestio/uptime-kuma";
    ports = [ "3001:3001" ];
  };
}
