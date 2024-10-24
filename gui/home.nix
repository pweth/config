/*
* Home manager configuration for GUI programs.
* See ../home/home.nix for CLI programs.
*/

{ config, pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./vscode.nix
    ./waybar.nix
    ./wofi.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    anki
    citrix_workspace
    discord
    galculator
    gnome.eog
    handbrake
    libreoffice
    obs-studio
    pinta
    shotcut
    spotify
    sqlitebrowser
    vlc
    webex
    wireshark
    zoom-us
  ];

  home.file = (builtins.mapAttrs (
    # Symlink GUI scripts
    name: value: {
      executable = true;
      source = ../static/scripts + "/${value}";
    }
  ) {
    ".local/bin/vpn" = "exit-node.sh";
  }) // {
    # Citrix EULA
    ".ICAClient/.eula_accepted".text = "yes";
  };

  # GTK dark theme
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
}
