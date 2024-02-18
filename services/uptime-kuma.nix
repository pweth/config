/*
* An easy-to-use self-hosted monitoring tool.
* https://github.com/louislam/uptime-kuma
*/

{ config, host, ... }:
let
  domain = "uptime.pweth.com";
  port = 58057;
  storage = "/var/lib/uptime-kuma";
in
{
  virtualisation.oci-containers.containers.uptime-kuma = {
    autoStart = true;
    image = "elestio/uptime-kuma";
    ports = [ "${builtins.toString port}:3001" ];
    volumes = [
      "${storage}:/app/data"
    ];
  };

  services.cloudflared.tunnels."${host.tunnel}".ingress = {
    "${domain}" = "http://localhost:${builtins.toString port}";
  };
}
