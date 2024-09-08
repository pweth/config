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
    standardnotes
    vlc
    webex
    wireshark
    zoom-us
  ];

  home.file = (builtins.mapAttrs (
    # Symlink GUI scripts
    name: value: {
      executable = true;
      source = ../../static/scripts + "/${value}";
    }
  ) {
    ".local/bin/bt" = "bluetooth.sh";
    ".local/bin/vpn" = "exit-node.sh";
    ".local/bin/wallpaper" = "wallpaper.sh";
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
