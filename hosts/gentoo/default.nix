/*
* Home application server system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  # Networking
  networking = {
    hostName = "gentoo";
    networkmanager.enable = true;
  };
}
