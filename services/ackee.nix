/*
* Self-hosted, Node.js based analytics tool.
* https://github.com/electerious/Ackee
*/

{ config, pkgs, ... }:

{
  age.secrets.ackee-password.file = ../secrets/ackee-password.age;

  services.nginx.virtualHosts."ackee.pw.ax".extraConfig = ''
    add_header  Access-Control-Allow-Origin "*" always;
    add_header  Access-Control-Allow-Methods "POST, OPTIONS" always;
    add_header  Access-Control-Allow-Headers "Content-Type, Authorization, Time-Zone" always;
    add_header  Access-Control-Allow-Credentials "true" always;
    add_header  Access-Control-Max-Age "3600" always;
  '';

  virtualisation.oci-containers.containers.ackee = {
    autoStart = true;
    dependsOn = [ "ackee-database" ];
    environment = {
      ACKEE_USERNAME = "admin";
      ACKEE_AUTO_ORIGIN = "true";
      ACKEE_MONGODB = "mongodb://localhost:27017/ackee";
      ACKEE_PORT = "42750";
      WAIT_HOSTS = "mongo:27017";
    };
    environmentFiles = [ config.age.secrets.ackee-password.path ];
    extraOptions = [ "--network=host" ];
    image = "electerious/ackee";
  };

  virtualisation.oci-containers.containers.ackee-database = {
    autoStart = true;
    image = "mongo";
    ports = [ "27017:27017" ];
    volumes = [
      "/home/pweth/ackee:/data/db"
    ];
  };
}
