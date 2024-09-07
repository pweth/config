/*
* NextDNS configuration.
*/

{ config, lib, pkgs, host, ... }:

{ 
  # Mount profile ID
  age.secrets.nextdns.file = ../secrets/nextdns.age;

  # Enable service
  services.nextdns.enable = true;

  # Modify systemd configuration
  systemd.services.nextdns.serviceConfig = {
    EnvironmentFile = config.age.secrets.nextdns.path;
    ExecStart = lib.mkForce (builtins.concatStringsSep " " [
      "${pkgs.nextdns}/bin/nextdns run"
      "-profile \${PROFILE}/${host.name}"
      "-detect-captive-portals"
      "-report-client-info"
    ]);
  };
}
