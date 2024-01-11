/*
* Oracle Cloud VM system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware.nix
    ../../services
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Networking
  networking.hostName = "macaroni";

  # ClamAV
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;
}
