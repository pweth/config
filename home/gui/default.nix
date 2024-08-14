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
    galculator
    gnome.eog
    handbrake
    libreoffice
    obs-studio
    pinta
    playerctl
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
  home.file = builtins.mapAttrs (
    name: value: {
      executable = true;
      source = ../../static/scripts + "/${value}";
    }
  ) {
    ".local/bin/bt" = "bluetooth.sh";
    ".local/bin/vpn" = "exit-node.sh";
    ".local/bin/wallpaper" = "wallpaper.sh";
  };

  # GTK dark theme
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
}
