{ config, pkgs, ... }:
let
  domain = "status.pw.ax";
in
{
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3001/";
      proxyWebsockets = true;
    };
  };

  security.acme.certs."${domain}" = {
    credentialsFile = config.age.secrets.cloudflare-api.path;
    dnsProvider = "cloudflare";
    group = "nginx";
  };

  virtualisation.oci-containers.containers.status = {
    autoStart = true;
    image = "elestio/uptime-kuma";
    ports = [ "3001:3001" ];
  };
}
