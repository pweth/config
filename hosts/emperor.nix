/*
* Personal laptop system configuration.
*/

{ config, lib, ... }:

{
  imports = [
    ../common/gui.nix
    ../services/rclone.nix
    ../services/rollback.nix
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

  # Impermenance
  environment.persistence."/persist" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos/config"
      "/var/lib/bluetooth"
      "/var/lib/docker"
      "/var/lib/systemd/coredump"
      "/var/lib/tailscale"
      "/var/log/journal"
    ];
    users.pweth = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        ".config"
        ".local/share/Anki2"
        ".local/share/keyrings"
        ".mozilla/firefox"
        ".ssh"
      ];
      files = [
        ".bash_history"
      ];
    };
  };
}
