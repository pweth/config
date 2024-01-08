/*
* Container services to run on the VPS.
*/

{ config, ... }:
let
  services = [
    { domain = "cowyo.pw.ax"; port = 44615; }
    { domain = "grafana.pw.ax"; port = 59663; }
    { domain = "prometheus.pw.ax"; port = 58635; }
    { domain = "uptime.pw.ax"; port = 58057; }
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
  age.secrets.cloudflare.file = ../secrets/cloudflare.age;

  # Establish Cloudflare tunnel
  services.cloudflared = {
    enable = true;
    tunnels = {
      "a972b5e1-8307-4574-a860-c92aaec5adce" = {
        credentialsFile = config.age.secrets.cloudflare.path;
        ingress = {
          # "*.domain1.com" = {
          #   service = "http://localhost:80";
          #   path = "/*.(jpg|png|css|js)";
          # };
          "cowyo.pweth.com" = "http://localhost:44615";
        };
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
