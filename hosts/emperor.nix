/*
* Personal laptop system configuration.
*/

{ config, lib, pkgs, host, user, ... }:

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
  home-manager.users."${user}".xdg.configFile."monitors.xml".source = ../static/monitors.xml;

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
    user = user;
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
    users."${user}" = {
      directories = [
        "Documents"
        "Downloads"
        ".config/Code"
        ".config/libreoffice"
        ".config/spotify"
        ".local/share/Anki2"
        ".local/share/Emote"
        ".local/share/keyrings"
        ".mozilla/firefox/default/extensions"
        ".mozilla/firefox/default/gmp-gmpopenh264" # Cisco H264 WebRTC plugin
        ".mozilla/firefox/default/storage/default/moz-extension+++35b124d1-b5b4-420f-8b13-59cb01336768^userContextId=4294967295" # uBlock Origin
        ".mozilla/firefox/default/storage/default/moz-extension+++bd411188-494b-4537-bbe3-22a0ff87bde8^userContextId=4294967295" # Bitwarden
        ".ssh"
      ];
      files = [
        ".bash_history"
        ".mozilla/firefox/default/addonStartup.json.lz4"
        ".mozilla/firefox/default/cookies.sqlite"
        ".mozilla/firefox/default/prefs.js"
        ".mozilla/firefox/default/storage.sqlite"
      ];
    };
  };
}
