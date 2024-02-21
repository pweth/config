/*
* Personal laptop system configuration.
*/

{ config, lib, pkgs, host, ... }:

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

  # Monitor setup
  home-manager.users.pweth.xdg.configFile."monitors.xml".source = ../static/monitors.xml;

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
  environment.persistence."${host.persistent}" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
    ];
    users.pweth = {
      directories = [
        "Documents"
        "Downloads"
        ".config/Code"
        ".config/libreoffice"
        ".config/pulse"
        ".config/spotify"
        ".local/share/Anki2"
        ".local/share/Emote"
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
