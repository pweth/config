/*
* An easy-to-use self-hosted monitoring tool.
* https://github.com/louislam/uptime-kuma
*/

{ config, host, ... }:

{
  virtualisation.oci-containers.containers.uptime-kuma = {
    autoStart = true;
    image = "elestio/uptime-kuma";
    ports = [ "${builtins.toString host.entrypoints.uptime-kuma.port}:3001" ];
    volumes = [
      "/home/pweth/uptime-kuma:/app/data"
    ];
  };
}
