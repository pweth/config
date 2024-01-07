/*
* Font configuration.
*/

{ config, pkgs, ... }:

{
  # Default font packages
  fonts = {
    packages = with pkgs; [
      hack-font
      noto-fonts
      noto-fonts-emoji
    ];
    fontconfig.defaultFonts = {
      serif = [ "NotoSerif" ];
      sansSerif = [ "NotoSans" ];
      monospace = [ "Hack" ];
    };
  };
}
