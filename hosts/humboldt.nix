/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/flatnotes.nix
    ../services/forgejo.nix
    ../services/grafana.nix
    ../services/jellyfin.nix
    ../services/masked-email.nix
    ../services/paperless.nix
    ../services/prometheus.nix
    ../services/restic.nix
    ../services/rollback.nix
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Tailscale exit node
  services.tailscale = {
    extraUpFlags = [ "--advertise-exit-node" ];
    useRoutingFeatures = "server";
  };

  # VSCode server
  services.vscode-server.enable = true;
}
