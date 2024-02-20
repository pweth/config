/*
* Home manager configuration for GUI programs.
* See ./default.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./firefox.nix
    ./gnome.nix
    ./vscode.nix
    ./whatsapp.nix
  ];

  home.packages = with pkgs; [
    anki
    discord
    emote
    gimp
    libreoffice
    obsidian
    obs-studio
    openshot-qt
    spotify
    sqlitebrowser
    texlive.combined.scheme-full
    texmaker
    vlc
    webex
    wireshark
    wl-clipboard
    zoom-us
  ];

  # Unwanted XDG base directories
  xdg.userDirs = {
    createDirectories = true;
    enable = true;
    desktop = null;
    music = null;
    pictures = "${config.home.homeDirectory}/Documents/Pictures";
    publicShare = null;
    templates = null;
    videos = null;
  };
}
