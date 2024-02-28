/*
* Oracle VM system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/uptime-kuma.nix
  ];

  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };
}
