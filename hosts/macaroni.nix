/*
* Oracle Cloud VM system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/cowyo.nix
    ../services/grafana.nix
    ../services/prometheus.nix
    ../services/uptime-kuma.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # ClamAV
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
