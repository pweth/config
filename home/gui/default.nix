/*
* Home manager configuration for GUI programs.
* See ../cli/default.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./firefox.nix
    ./gnome.nix
    ./nautilus.nix
    ./vscode.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    anki
    discord
    dolphin-emu
    emote
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
}
