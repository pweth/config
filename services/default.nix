/*
* Reverse proxy via cloudflared for services.
*/

{ config, host, ... }:

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
        ingress = builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs (
          name: value: {
            name = value.domain;
            value = "http://localhost:${builtins.toString value.port}";
          }
        ) host.entrypoints));
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
