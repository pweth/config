/*
* Home manager configuration for GUI programs.
* See ../home/home.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./vscode.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    anki
    citrix_workspace
    discord
    galculator
    gnome.eog
    handbrake
    libreoffice
    obs-studio
    pinta
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
