# * Font configuration.

{ config, pkgs, ... }:

{
  # Default font packages
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "NotoColorEmoji" ];
        sansSerif = [ "NotoSans" ];
        serif = [ "NotoSerif" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
    fontDir.enable = true;
  };
}
