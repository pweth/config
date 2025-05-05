# * Custom Python web service for generating FastMail email aliases.

{ config, lib, host, pkgs, ... }:

{
  config = lib.mkIf (builtins.elem "masked-email" host.services) {
    # Masked email Python script
    age.secrets.masked-email.file = ../secrets/masked-email.age;

    modules.services.masked-email = {
      subdomain = "mask";
      address = "192.168.1.8";

      mounts = {
        "${config.age.secrets.masked-email.path}".hostPath = config.age.secrets.masked-email.path;
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
