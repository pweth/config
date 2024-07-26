/*
* Personal laptop system configuration.
*/

{ config, lib, user, ... }:

{
  imports = [
    ../common/gui.nix
    ../services/restic.nix
    ../services/rollback.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Logitech peripherals
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # Monitor setup
  home-manager.users."${user}".xdg.configFile."monitors.xml".source = ../static/monitors.xml;

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Disable SSH
  services.openssh.enable = lib.mkForce false;

  # Tailscale client
  services.tailscale.useRoutingFeatures = "client";
}
