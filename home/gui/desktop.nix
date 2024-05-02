/*
* GNOME .desktop entry configuration.
*/

{ config, pkgs, ... }:
let
  hidden = [
    "base"
    "blueman-manager"
    "draw"
    "emote"
    "htop"
    "jupyterlab"
    "jupyter-notebook"
    "math"
    "nvim"
    "startcenter"
    "xdvi"
  ];
  rename = with pkgs; [
    { name = "calc"; pkg = libreoffice; from = "LibreOffice 7.5 Calc"; to = "Excel"; }
    { name = "impress"; pkg = libreoffice; from = "LibreOffice 7.5 Impress"; to = "PowerPoint"; }
    { name = "sqlitebrowser"; pkg = sqlitebrowser; from = "DB Browser for SQLite"; to = "DB Browser"; }
    { name = "vlc"; pkg = vlc; from = "VLC media player"; to = "VLC"; }
    { name = "writer"; pkg = libreoffice; from = "LibreOffice 7.5 Writer"; to = "Word"; }
  ];
in
{
  home.file = builtins.listToAttrs (builtins.map (app: {
    name = ".local/share/applications/${app}.desktop";
    value.text = ''
      [Desktop Entry]
      Hidden=true
    '';
  }) hidden) // builtins.listToAttrs (builtins.map (app: {
    name = ".local/share/applications/${app.name}.desktop";
    value.text = (
      builtins.replaceStrings
      [ "Name=${app.from}" "Name[en_GB]=${app.from}" ]
      [ "Name=${app.to}" "Name[en_GB]=${app.to}" ]
      (builtins.readFile ("${app.pkg}/share/applications/${app.name}.desktop"))
    );
  }) rename);
}
