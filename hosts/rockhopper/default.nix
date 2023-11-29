/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, agenix, ... }:

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

  # agenix
  environment.systemPackages = [
    agenix.packages.aarch64-linux.default
  ];

  # Networking
  networking = {
    hostName = "rockhopper";
    nameservers = [ "1.1.1.3" "1.0.0.3" ];
  };
}
