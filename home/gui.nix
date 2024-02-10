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
    bitwarden
    discord
    emote
    gimp
    libreoffice
    obsidian
    obs-studio
    spicetify-cli
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
}
