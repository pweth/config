/*
* XDG base directory configuration.
*/

{ config, ... }:

{
  xdg = {
    # `Open with...` defaults
    mimeApps = let
      defaultApps = {
        "application/pdf" = "firefox.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "video/avi" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
      };
    in
    {
      enable = true;
      associations.added = defaultApps;
      defaultApplications = defaultApps;
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
