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
  home-manager.users."${user}".xdg.configFile."monitors.xml".source = ../static/misc/monitors.xml;

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
  services.displayManager.autoLogin = {
    enable = true;
    user = user;
  };
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Disable SSH
  services.openssh.enable = lib.mkForce false;

  # Tailscale client
  services.tailscale = {
    extraUpFlags = [ "--operator=${user}" ];
    useRoutingFeatures = "client";
  };

  # Override timezone to Sydney
  time.timeZone = lib.mkForce "Australia/Sydney";

  # Enable Docker
  virtualisation = {
    docker.enable = true;
    oci-containers.backend = "docker";
  };
}
