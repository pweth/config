/*
* Oracle Cloud VM system configuration.
*/

{ config, ... }:

{
  # imports = [
  #   ./cowyo.nix # moo.pweth.com
  #   ./grafana.nix # grafana.pweth.com
  #   ./prometheus.nix # prometheus.pweth.com
  #   ./uptime-kuma.nix # uptime.pweth.com
  # ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # ClamAV
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
