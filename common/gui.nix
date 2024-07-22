/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, user, ... }:

{
  # GUI setup
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      excludePackages = [ pkgs.xterm ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    firefox
    gparted
    vscode
  ];

  # Exclude optional GNOME packages
  environment.gnome.excludePackages = (with pkgs; [
    baobab
    epiphany
    evince
    gedit
    gnome-connections
    gnome-photos
    gnome-text-editor
    gnome-tour
    simple-scan
    yelp
  ]) ++ (with pkgs.gnome; [
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
    totem
  ]);

  # Home manager GUI packages
  home-manager.users."${user}" = import ../home/gui;
}
