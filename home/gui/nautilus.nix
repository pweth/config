/*
* GNOME file explorer configuration.
*/

{ config, ... }:

{
  # Set default viewer settings
  dconf.settings = {
    "org/gnome/nautilus/list-view" = {
      default-zoom-level = "medium";
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
    };
  };

  # Bookmarks
  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///etc/nixos/config
  '';
}
