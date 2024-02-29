/*
* Unofficial Bitwarden compatible server written in Rust.
* https://github.com/dani-garcia/vaultwarden
*/

{ config, lib, host, ... }:
let
  domain = "vault.pweth.com";
  port = 22918;
  storage = "/var/lib/vaultwarden";
in
{
  # Docker container
  virtualisation.oci-containers.containers.vaultwarden = {
    autoStart = true;
    environment = {
      DOMAIN = "https://${domain}";
      SHOW_PASSWORD_HINT = "false";
      SIGNUPS_ALLOWED = "false";
    };
    image = "vaultwarden/server:latest";
    ports = [ "${builtins.toString port}:80" ];
    volumes = [
      "${storage}:/data"
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    acmeRoot = null;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ storage ];
  };
}
