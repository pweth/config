/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../common/ssh.nix
  ];

  # Bootloader
  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  # Networking
  networking = {
    hostName = "rockhopper";
    nameservers = [ "127.0.0.1" "::1" ];
  };
}
