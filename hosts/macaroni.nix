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

  # ClamAV and fail2ban
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
  services.fail2ban.enable = true;
}
