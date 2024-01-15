/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };
}
