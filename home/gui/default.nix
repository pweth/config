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
    emote
    handbrake
    libreoffice
    obs-studio
    pinta
    shotcut
    spotify
    sqlitebrowser
    texlive.combined.scheme-full
    texmaker
    vlc
    webex
    wireshark
    zoom-us
  ];
}
