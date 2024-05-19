/*
* A self-hosted, database-less note taking web app.
* https://github.com/Dullage/flatnotes
*/

{ config, lib, host, ... }:
let
  domain = "notes.pweth.com";
  port = 44615;
  storage = "/var/lib/flatnotes";
in
{
  # Mount environment file
  age.secrets.flatnotes.file = ../secrets/flatnotes.age;

  # Docker container
  virtualisation.oci-containers.containers.flatnotes = {
    autoStart = true;
    environmentFiles = [ config.age.secrets.flatnotes.path ];
    image = "dullage/flatnotes:latest";
    ports = [ "${builtins.toString port}:8080" ];
    volumes = [
      "${storage}:/data"
    ];
  };

  # Internal domain
  services.nginx.virtualHosts."${domain}" = {
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${builtins.toString port}";
      proxyWebsockets = true;
    };
    useACMEHost = "internal";
  };

  # Persist service data
  environment.persistence = lib.mkIf (builtins.hasAttr "persistent" host) {
    "${host.persistent}".directories = [ storage ];
  };
}
