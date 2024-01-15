/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ../services
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
