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
    bitwarden
    emote
    gimp
    libreoffice
    obsidian
    obs-studio
    spotify
    sqlitebrowser
    vlc
  ];
}
