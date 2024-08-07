/*
* XDG base directory configuration.
*/

{ config, ... }:

{
  xdg.userDirs = {
    # Create bases automatically
    createDirectories = true;
    enable = true;
  
    # Disable unwanted bases
    desktop = null;
    music = null;
    publicShare = null;
    templates = null;
    videos = null;
  };
}
