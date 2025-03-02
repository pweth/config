/*
  * Home manager configuration for GUI programs.
  * See ../home/home.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./vscode.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    anki
    citrix_workspace
    eog
    galculator
    handbrake
    libreoffice
    obs-studio
    pinta
    qFlipper
    shotcut
    spotify
    sqlitebrowser
    vlc
    webex
    wireshark
    zoom-us
  ];

  # Citrix EULA
  home.file.".ICAClient/.eula_accepted".text = "yes";

  # GTK bookmarks and dark theme
  xdg.configFile = {
    "gtk-3.0/bookmarks".text = ''
      file:///etc/nixos/config
    '';
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
  };

  # User base directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    music = null;
    publicShare = null;
    templates = null;
    videos = null;
  };
}
