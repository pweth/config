/*
* Container services to run on the VPS.
*/

{ config, pkgs, ... }:
let
  services = [
    { domain = "cowyo.pw.ax"; port = 8050; }
    { domain = "status.pw.ax"; port = 3001; }
  ];
in
{
  imports = [
    ./cowyo.nix
    ./uptime-kuma.nix
  ];

  # Certificates
  security.acme.certs = builtins.listToAttrs (builtins.map (service: {
    name = service.domain;
    value = {
      credentialsFile = config.age.secrets.cloudflare-api.path;
      dnsProvider = "cloudflare";
      group = "nginx";
    };
  }) services);

  # Reverse proxy hosts
  services.nginx.virtualHosts = builtins.listToAttrs (builtins.map (service : {
    name = service.domain;
    value = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${builtins.toString service.port}/";
        proxyWebsockets = true;
      };
      useACMEHost = service.domain;
    };
  }) services);
}
