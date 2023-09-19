{ config, pkgs, ... }:
let
  domain = "cowyo.pw.ax";
in
{
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:8050/";
  };

  security.acme.certs."${domain}" = {
    credentialsFile = config.age.secrets.cloudflare-api.path;
    dnsProvider = "cloudflare";
    group = "nginx";
  };

  virtualisation.oci-containers.containers.cowyo = {
    autoStart = true;
    image = "schollz/cowyo";
    ports = [ "8050:8050" ];
  };
}
