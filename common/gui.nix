/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, user, ... }:

{
  imports = [
    ../services/doh-proxy.nix
  ];

  # GUI setup
  services.libinput.enable = true;
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    firefox
    gparted
    vscode
    xvkbd
  ];

  # Exclude unwanted default Gnome packages
  environment.gnome.excludePackages = (with pkgs; [
    gedit
    gnome-connections
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    baobab
    epiphany
    evince
    file-roller
    geary
    gnome-calendar
    gnome-characters
    gnome-contacts
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    seahorse
    simple-scan
    totem
    yelp
  ]);

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Home manager GUI packages
  home-manager.users."${user}" = import ../home/gui;

  # NetworkManager
  networking.networkmanager.enable = true;

  # Input remapper
  services.input-remapper.enable = true;
  systemd.services.input-remapper-autoload = {
    serviceConfig = {
      ExecStart = "${pkgs.input-remapper}/bin/input-remapper-control --command autoload";
      Type = "oneshot";
      User = user;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
