/*
* Font configuration.
*/

{ config, pkgs, ... }:

{
  # Default font packages
  fonts = {
    packages = with pkgs; [
      hack-font
      jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "NotoColorEmoji" ];
        sansSerif = [ "NotoSans" ];
        serif = [ "NotoSerif" ];
        monospace = [ "Hack" ];
      };
    };
  };
}
