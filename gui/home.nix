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
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    anki
    citrix_workspace
    discord
    galculator
    glfw-wayland-minecraft
    gnome.eog
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

  # GTK dark theme
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
}
