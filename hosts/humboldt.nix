/*
* Home server system configuration.
*/

{ config, ... }:

{
  # Bootloader
  boot.loader.grub = {
    enable = false;
    device = "/dev/sda";
  };
}
