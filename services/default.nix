/*
* Container services to run on the VPS.
*/

{ config, ... }:

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
        ingress = {
          "grafana.pweth.com" = "http://localhost:59663";
          "moo.pweth.com" = "http://localhost:44615";
          "prometheus.pweth.com" = "http://localhost:58635";
	  "status.pweth.com" = "http://localhost:58057";
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
