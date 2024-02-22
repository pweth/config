/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/rollback.nix
  ];
  
  # Bootloader
  boot.loader.grub = {
    enable = false;
    device = "/dev/sda";
  };
}
