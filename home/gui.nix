/*
* Home manager configuration for GUI programs.
* See ./default.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
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
    gnome.eog
    libreoffice
    obsidian
    obs-studio
    spotify
    sqlitebrowser
    texlive.combined.scheme-full
    texmaker
    vlc
    wireshark
  ];
}
