{ config, pkgs, ... }:
let
  domain = "dav.pw.ax";
in
{
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:8000/";
  };

  security.acme.certs."${domain}" = {
    credentialsFile = config.age.secrets.cloudflare-api.path;
    dnsProvider = "cloudflare";
    group = "nginx";
  };

  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "ghcr.io/jelmer/xandikos";
    ports = [ "8000:8000" ];
  };
}
