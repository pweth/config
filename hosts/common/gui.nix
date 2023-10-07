/*
* Common system configuration across all hosts with a GUI.
*/

{ config, pkgs, home-manager, ... }:

{
  # GUI setup
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    excludePackages = [ pkgs.xterm ];
    libinput.enable = true;
  };

  # Exclude unwanted default Gnome packages
  environment.gnome.excludePackages = (with pkgs; [
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
    gedit
    gnome-calendar
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    seahorse
    simple-scan
    totem
    yelp
  ]);

  # Home manager GUI packages
  home-manager.users.pweth = import ../../home/gui.nix;
}
