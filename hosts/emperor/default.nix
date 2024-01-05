/*
* Personal laptop system configuration.
*/

{ config, pkgs, home-manager, ... }:

{
  imports = [
    ./hardware.nix
    ../../common/rclone.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

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
  age.secrets.wifi.file = ../../secrets/wifi.age;

  # tmux
  programs.bash.interactiveShellInit = ''
    [[ -z "$TMUX" ]] && exec tmux new -As0
  '';

  # Sound and Bluetooth
  sound.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Auto-login on boot
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "pweth";
  };
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "pweth" ];
}
