/*
* GNOME .desktop entry configuration.
*/

{ config, ... }:
let
  hidden = [
    "base"
    "blueman-manager"
    "draw"
    "htop"
    "math"
    "nvim"
    "startcenter"
    "xdvi"
  ];
in
{
  home.file = builtins.listToAttrs (builtins.map (app: {
    name = ".local/share/applications/${app}.desktop";
    value.text = ''
      [Desktop Entry]
      Hidden=true
    '';
  }) hidden);
}
