/*
* Oracle Cloud Micro VM system configuration.
*/

{ config, ... }:

{
  # Bootloader
  boot.loader.grub = {
    device = "nodev";
    efiInstallAsRemovable = true;
    efiSupport = true;
  };
}
