/*
* Personal laptop system configuration.
*/

{ config, lib, pkgs, host, user, ... }:

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

  # Monitor setup
  home-manager.users."${user}".xdg.configFile."monitors.xml".source = ../static/monitors.xml;

  # Network manager
  networking.networkmanager.enable = true;

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
    user = user;
  };
  systemd.services = {
    "autovt@tty1".enable = false;
    "getty@tty1".enable = false;
  };

  # Disable SSH
  services.openssh.enable = lib.mkForce false;

  # Impermenance
  environment.persistence."${host.persistent}".users."${user}".directories = [
    "Documents"
    "Downloads"
    ".config/Code"
    ".config/libreoffice"
    ".config/spotify"
    ".local/share/Anki2"
    ".local/share/Emote"
    ".local/share/keyrings"
    ".mozilla/firefox/default"
    ".passage"
    ".ssh"
  ];
}
