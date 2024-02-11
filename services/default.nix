/*
* Reverse proxy via cloudflared for services.
*/

{ config, host, ... }:
let
  entrypoints = {
    "moo.pweth.com" = 44615;
    "grafana.pweth.com" = config.services.grafana.settings.server.http_port;
    "prometheus.pweth.com" = config.services.prometheus.port;
    "uptime.pweth.com" = 58057;
  };
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
        ) entrypoints;
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
