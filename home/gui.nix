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
  ];

  home.packages = with pkgs; [
    appimage-run
    bitwarden
    emote
    gimp
    gnome.eog
    libreoffice
    obsidian
    obs-studio
    spotify
    sqlitebrowser
    vlc
  ];
}
