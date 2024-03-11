/*
* Custom Python web service for generating FastMail email aliases.
*/

{ config, pkgs, ... }:
let
  domain = "mask.pweth.com";
  port = 40368;
in
{
  # Mount environment file
  age.secrets.masked-email.file = ../secrets/masked-email.age;

  # Systemd service
  systemd.services.masked-email = {
    serviceConfig = {
      ExecStart = "${pkgs.python3}/bin/python ${config.age.secrets.masked-email.path}";
      RestartSec = 120;
    };

    environment.SERVICE_RUN_MODE = "1";
    startLimitBurst = 10;
    startLimitIntervalSec = 5;
    after = [ "run-agenix.d.mount" ];
    wants = [ "run-agenix.d.mount" ];
    wantedBy = [ "multi-user.target" ];
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
}
