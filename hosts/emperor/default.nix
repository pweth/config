/*
* Personal laptop system configuration.
*/

{ config, pkgs, agenix, home-manager, ... }:

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

  # Home manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.pweth = import ../../home;
  };

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

  # Docker
  virtualisation.docker.enable = true;

  # VirtualBox
  virtualisation.virtualbox = {
    guest.enable = true;
    guest.x11 = true;
    host.enable = true;
  };

  # Extra groups for virtualisation
  users.extraGroups = {
    docker.members = [ "pweth" ];
    vboxusers.members = [ "pweth" ];
  };
}
