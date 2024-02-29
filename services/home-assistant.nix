/*
* A feature-rich wiki for minimalists.
* https://github.com/schollz/cowyo
*/

{ config, lib, host, ... }:
let
  domain = "home.pweth.com";
  port = 8123;
  storage = "/var/lib/home-assistant";
in
{
  # Docker container
  virtualisation.oci-containers.containers.home-assistant = {
    autoStart = true;
    image = "homeassistant/home-assistant";
    extraOptions = [
      "--network=host"
      "--privileged"
    ];
    volumes = [
      "${storage}:/config"
      "/etc/localtime:/etc/localtime:ro"
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
    "${host.persistent}".directories = [ "/var/lib/home-assistant" ];
  };
}
