{ config, pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./gnome.nix
    ./vscode.nix
  ];

  # GUI user packges not imported as modules
  home.packages = with pkgs; [
    appimage-run
    bitwarden
    emote
    gimp
    keybase
    libreoffice
    obsidian
    spotify
    sqlitebrowser
    vlc
  ];
}
