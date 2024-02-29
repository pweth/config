/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, lib, host, ... }:
let
  domain = "moo.pweth.com";
  port = 44615;
  storage = "/var/lib/cowyo";
in
{
  # Docker container
  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "schollz/cowyo";
    ports = [ "${builtins.toString port}:8050" ];
    volumes = [
      "${storage}:/data"
    ];
  };

  # Cloudflare tunnel
  services.cloudflared.tunnels."${host.tunnel}".ingress = {
    "${domain}" = "http://localhost:${builtins.toString port}";
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ storage ];
  };
}
