/*
* Raspberry Pi system configuration.
*/

{ config, ... }:

{
  # Bootloader
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };
}
