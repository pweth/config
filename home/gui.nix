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
    ./web-apps.nix
  ];

  home.packages = with pkgs; [
    appimage-run
    bitwarden
    discord
    emote
    gimp
    libreoffice
    obsidian
    obs-studio
    spotify
    sqlitebrowser
    texlive.combined.scheme-full
    texmaker
    vlc
    wireshark
    wl-clipboard
  ];
}
