/*
* NextDNS proxy (DNS-over-HTTPS) configuration.
*/

{ config, pkgs, ... }:

{
  # Mount profile ID
  age.secrets.nextdns.file = ../secrets/nextdns.age;

  # Set DNS servers to localhost
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
  };

  # Systemd DNS-over-HTTPS service
  systemd.services.nextdns = {
    serviceConfig = {
      EnvironmentFile = config.age.secrets.nextdns.path;
      ExecStart = builtins.concatStringsSep " " [
        "${pkgs.nextdns}/bin/nextdns run -profile"
        "\${PROFILE}/${config.networking.hostName}"
      ];
      RestartSec = 120;
      LimitMEMLOCK = "infinity";
    };

    environment.SERVICE_RUN_MODE = "1";
    startLimitBurst = 10;
    startLimitIntervalSec = 5;
    after = [ "network.target" "run-agenix.d.mount" ];
    before = [ "nss-lookup.target" ];
    wants = [ "nss-lookup.target" "run-agenix.d.mount" ];
    wantedBy = [ "multi-user.target" ];
  };
}
