/*
* Home application server system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # NetworkManager
  networking.networkmanager.enable = true;
}
