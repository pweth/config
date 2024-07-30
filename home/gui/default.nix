/*
* Home manager configuration for GUI programs.
* See ../cli/default.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
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

  # Symlink GUI scripts
  home.file = {
    ".local/bin/bt" = {
      executable = true;
      source = ../../static/scripts/bluetooth.sh;
    };
    ".local/bin/wp" = {
      executable = true;
      source = ../../static/scripts/wallpaper.sh;
    };
  };

  # GTK dark theme
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
}
