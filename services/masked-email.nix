# * Custom Python web service for generating FastMail email aliases.

{ config, lib, host, pkgs, ... }:

{
  config = lib.mkIf (builtins.elem "masked-email" host.services) {
    age.secrets.masked-email.file = ../secrets/masked-email.age;

    modules.services.masked-email = {
      subdomain = "mask";

      mounts = {
        "${config.age.secrets.masked-email.path}".isReadOnly = true;
      };

      config.systemd.services.masked-email = {
        after = [ "tailscaled.service" ];
        wantedBy = [ "tailscaled.service" ];
        serviceConfig.ExecStart = let
          python = pkgs.python3.withPackages (ps: with ps; [ requests ]);
        in "${python}/bin/python ${config.age.secrets.masked-email.path}";
      };
    };
  };
}
