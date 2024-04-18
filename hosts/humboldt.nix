/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/acme.nix
    ../services/cgit.nix
    ../services/flatnotes.nix
    ../services/grafana.nix
    ../services/home-assistant.nix
    ../services/jellyfin.nix
    ../services/masked-email.nix
    ../services/paperless.nix
    ../services/prometheus.nix
    ../services/restic.nix
    ../services/rollback.nix
    ../services/uptime-kuma.nix
    ../services/vaultwarden.nix
  ];
  
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # VSCode server
  services.vscode-server.enable = true;
}
