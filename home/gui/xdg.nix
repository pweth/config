/*
* XDG base directory configuration.
*/

{ config, ... }:

{
  xdg = {
    # `Open with...` defaults
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = "firefox.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
      };
      defaultApplications = {
        "application/pdf" = "firefox.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
      };
    };

    userDirs = {
      # Create bases automatically
      createDirectories = true;
      enable = true;
    
      # Disable unwanted bases
      desktop = null;
      music = null;
      publicShare = null;
      templates = null;
      videos = null;

      # Move ~/Pictures inside ~/Documents
      pictures = "${config.home.homeDirectory}/Documents/Pictures";
    };
  };
}
