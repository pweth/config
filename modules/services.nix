# * NixOS container tailnet services module.

{
  config,
  lib,
  pkgs,
  host,
  ...
}:
let
  cfg = config.modules.services;
in
{
  options.modules.services = lib.mkOption {
    default = { };
    type = lib.types.attrsOf (lib.types.submodule ({ name, config, ... }: {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Service name.";
        };
        subdomain = lib.mkOption {
          type = lib.types.str;
          default = name;
          description = "Internal subdomain.";
        };
        port = lib.mkOption {
          type = lib.types.int;
          default = 12345;
          description = "Service port to expose.";
        };
        mounts = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Container bind mounts.";
        };
        config = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Service configuration.";
        };
      };
    }));
    description = "NixOS container tailnet services.";
  };

  config = lib.mkIf (cfg != { }) {
    # Mount Tailscale container auth key
    age.secrets.tailscale.file = ../secrets/tailscale.age;

    # Enable network address translation
    networking.nat.enable = true;
    networking.nat.internalInterfaces = [ "ve-+" ];

    containers = builtins.mapAttrs (name: options: {
      autoStart = true;

      # Ephemeral file system
      ephemeral = true;
      bindMounts = {
        "${config.age.secrets.certificate.path}".hostPath = config.age.secrets.certificate.path;
        "${config.age.secrets.tailscale.path}".hostPath = config.age.secrets.tailscale.path;
      } // options.mounts;

      # Private networking
      privateNetwork = true;
      enableTun = true;
      hostAddress = "192.168.100.1";
      localAddress = "192.168.100.${builtins.toString (
        (lib.lists.findFirstIndex (service: service == name) null host.services) + 2
      )}";

      # Container configuration
      config = lib.mkMerge [options.config ({ pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "24.11";

        # Reverse proxy
        services.nginx = {
          enable = true;
          clientMaxBodySize = "0";
          recommendedGzipSettings = true;
          recommendedOptimisation = true;
          recommendedProxySettings = true;
          recommendedTlsSettings = true;
          recommendedZstdSettings = true;

          virtualHosts."${options.subdomain}.pweth.com" = {
            forceSSL = true;
            locations."/" = {
              proxyPass = "http://localhost:${builtins.toString options.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;
            };
            sslCertificate = ../static/pweth.crt;
            sslCertificateKey = config.age.secrets.certificate.path;
          };
        };

        # Ephemeral Tailscale
        # Ref: https://github.com/tailscale/tailscale/issues/4778#issuecomment-1229366518
        services.tailscale = {
          enable = true;
          extraDaemonFlags = [ "--state=mem:" ];
        };

        # Custom tailscaled-autoconnect systemd service
        systemd.services.tailscaled-autoconnect = {
          after = [ "tailscaled.service" ];
          wantedBy = [ "tailscaled.service" ];
          serviceConfig.ExecStart = builtins.concatStringsSep " " [
            "${pkgs.tailscale}/bin/tailscale"
            "up"
            "--auth-key file:${config.age.secrets.tailscale.path}"
            "--hostname ${options.subdomain}"
            "--advertise-tags tag:container,tag:${options.subdomain}"
          ];
        };
      })];
    }) cfg;
  };
}
