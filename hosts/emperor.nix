/*
* Personal laptop system configuration.
*/

{ config, pkgs, home-manager, lib, ... }:

{
  imports = [
    ../common/gui.nix
    ../services/rclone.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  age.secrets.wifi.file = ../secrets/wifi.age;

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
  services.pcscd.enable = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "pweth";
  };
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Disable SSH
  services.openssh.enable = lib.mkForce false;
}
