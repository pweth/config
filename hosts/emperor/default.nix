/*
* Personal laptop system configuration.
*/

{ config, pkgs, agenix, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # agenix
  environment.systemPackages = [
    agenix.packages.x86_64-linux.default
  ];

  # Networking
  networking = {
    hostName = "emperor";
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager.dns = "none";
    networkmanager.enable = true;
  };

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # System services
  services.keybase.enable = true;
  services.printing.enable = true;

  # NextDNS proxy (DNS-over-HTTPS)
  services.nextdns = {
    enable = true;
    arguments = [ "-profile" "ffa426" ];
  };
}
