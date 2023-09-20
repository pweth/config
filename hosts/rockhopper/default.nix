/*
* Raspberry Pi system configuration.
*/

{ config, pkgs, agenix, ... }:

{
  imports = [
    ./hardware.nix
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

  # Home manager
  home-manager.users.pweth = import ../../home/minimal.nix;

  # Networking
  networking = {
    hostName = "rockhopper";
    nameservers = [ "1.1.1.3" "1.0.0.3" ];
  };

  # Secure Shell
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };
}
