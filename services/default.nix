/*
* Container services to run on the VPS.
*/

{ config, ... }:
let
  entrypoints = [
    { name = "grafana.pweth.com"; value = config.services.grafana.settings.server.http_port; }
    { name = "moo.pweth.com"; value = 44615; }
    { name = "prometheus.pweth.com"; value = config.services.prometheus.port; }
    { name = "uptime.pweth.com"; value = 58057; }
  ];
in
{
  imports = [
    ./cowyo.nix
    ./grafana.nix
    ./prometheus.nix
    ./uptime-kuma.nix
  ];

  # Credentials file
  age.secrets.cloudflare = {
    file = ../secrets/cloudflare.age;
    owner = "cloudflared";
  };

  # Establish Cloudflare tunnel
  services.cloudflared = {
    enable = true;
    tunnels = {
      "a972b5e1-8307-4574-a860-c92aaec5adce" = {
        credentialsFile = config.age.secrets.cloudflare.path;
        ingress = builtins.mapAttrs (
          name: value: "http://localhost:${builtins.toString value}"
        ) (builtins.listToAttrs entrypoints);
        default = "http_status:404";
      };
    };
  };

  # Enable Docker
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
}
