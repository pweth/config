/*
* Home server system configuration.
*/

{ config, ... }:

{
  imports = [
    ../services/cowyo.nix
    ../services/home-assistant.nix
    ../services/paperless.nix
    ../services/rollback.nix
  ];
  
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
}
