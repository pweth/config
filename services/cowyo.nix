/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, host, ... }:
let
  domain = "moo.pweth.com";
  port = 44615;
  storage = "/var/lib/cowyo";
in
{
  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "matosama/cowyo";
    ports = [ "${builtins.toString port}:8050" ];
    volumes = [
      "${storage}:/data"
    ];
  };

  services.cloudflared.tunnels."${host.tunnel}".ingress = {
    "${domain}" = "http://localhost:${builtins.toString port}";
  };
}
