{ config, pkgs, ... }:
let
  domain = "radicale.pw.ax";
in
{
  services.nginx.virtualHosts."${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:5232/";
  };

  security.acme.certs."${domain}" = {
    credentialsFile = config.age.secrets.cloudflare-api.path;
    dnsProvider = "cloudflare";
    group = "nginx";
  };

  age.secrets.radicale-users.file = ../secrets/radicale-users.age;

  virtualisation.oci-containers.containers.radicale = {
    autoStart = true;
    image = "rockstorm/radicale";
    ports = [ "5232:5232" ];
    volumes = [
       "${../static/radicale.config}:/etc/radicale/config:ro"
       "${config.age.secrets.radicale-users.path}:/etc/radicale/users:ro"
    ];
  };
}
