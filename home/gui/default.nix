/*
* Home manager configuration for GUI programs.
* See ../cli/default.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./emote.nix
    ./firefox.nix
    ./vscode.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    anki
    discord
    gnome.eog
    handbrake
    libreoffice
    obs-studio
    pinta
    shotcut
    spotify
    sqlitebrowser
    standardnotes
    vlc
    webex
    wireshark
    zoom-us
  ];

  # GTK dark theme
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
}
